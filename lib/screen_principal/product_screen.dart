import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api_model/product_api.dart';
import '../api_model/product_model.dart';
import '../product_card_widget/product_card.dart';
import '../user_date/UserInfoWidget.dart';
import '../product_card_widget/category_chips.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> _futureProducts;
  String? _userName;
  String? _userPhotoUrl;
  List<Product> _allProducts = [];
  List<String> _allCategories = ['All'];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _futureProducts = ProductApi.fetchProducts();
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userName = user.displayName;
        _userPhotoUrl = user.photoURL;
      });
    }
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _futureProducts = ProductApi.fetchProducts();
    });
  }

  void _extractCategories(List<Product> products) {
    _allCategories.clear();
    Set<String> categorySet = Set();
    products.forEach((product) {
      categorySet.add(product.categoryName);
    });
    _allCategories.addAll(categorySet.toList());
  }

  List<Product> _getFilteredProducts() {
    if (selectedCategory == null || selectedCategory == 'All') {
      return _allProducts;
    } else {
      return _allProducts.where((product) => product.categoryName == selectedCategory).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoWidget(
              userName: _userName,
              userPhotoUrl: _userPhotoUrl,
            ),
            FutureBuilder<List<Product>>(
              future: _futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Product> products = snapshot.data!;
                  _allProducts = products;
                  _extractCategories(products);

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryChips(
                          categories: _allCategories,
                          onSelectCategory: (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          }, selectedCategory: '',
                        ),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: _getFilteredProducts().map((product) {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: ProductCard(
                                  product: product,
                                  onFavoriteToggle: () {
                                    // Lógica para alternar favoritos
                                  },
                                  isFavorite: false,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
