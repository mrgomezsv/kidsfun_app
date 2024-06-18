import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api_model/product_api.dart';
import '../api_model/product_model.dart';
import '../product_card_widget/product_card.dart';
import '../user_date/UserInfoWidget.dart'; // Asegúrate de que la ruta sea correcta según la estructura de tus carpetas

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> _futureProducts;
  String? _userName;
  String? _userPhotoUrl;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: Column(
          children: [
            UserInfoWidget(
              userName: _userName,
              userPhotoUrl: _userPhotoUrl,
            ),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return GridView.count(
                      crossAxisCount: 2, // Aquí estableces el número de elementos por fila
                      children: snapshot.data!.map((product) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ProductCard(
                            product: product,
                            onFavoriteToggle: () {
                              // Lógica para alternar favoritos
                            },
                            isFavorite: false, // Cambia esto si tienes un sistema de favoritos
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
