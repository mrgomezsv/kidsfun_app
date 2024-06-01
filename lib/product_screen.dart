import 'package:flutter/material.dart';
import 'product_api.dart';
import 'product_model.dart';
import 'product_card.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> _futureProducts;
  List<bool> _isFavoriteList = [];

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductApi.fetchProducts();
    _futureProducts.then((products) {
      setState(() {
        _isFavoriteList = List<bool>.filled(products.length, false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final product = snapshot.data![index];
                return ProductCard(
                  product: product,
                  isFavorite: _isFavoriteList[index],
                  onFavoriteToggle: () {
                    setState(() {
                      _isFavoriteList[index] = !_isFavoriteList[index];
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
