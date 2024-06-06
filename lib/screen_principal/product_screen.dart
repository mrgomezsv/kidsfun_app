import 'package:flutter/material.dart';
import '../api_model/product_api.dart';
import '../api_model/product_model.dart';
import '../product_card_widget/product_card.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductApi.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Products'),
      // ),
      body: FutureBuilder<List<Product>>(
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
    );
  }
}
