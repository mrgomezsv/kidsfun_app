import 'package:flutter/material.dart';
import '../api_model/product_model.dart'; // Asegúrate de importar Product si no lo has hecho ya

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  const ProductCard({
    required this.product,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Ajusta el radio según sea necesario
      ),
      child: SizedBox(
        height: 250, // Aquí puedes ajustar la altura del card según tus necesidades
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0), // Mismo radio que el Card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Image.network(
                    product.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //SizedBox(height: 4),
                    // Text(
                    //   product.description,
                    //   style: TextStyle(color: Colors.grey),
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    //SizedBox(height: 4),
                    // Text(
                    //   '\$${product.price}',
                    //   style: TextStyle(color: Colors.green),
                    // ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {
                      // Lógica para Comentar
                    },
                    iconSize: 22,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: onFavoriteToggle,
                    iconSize: 22,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Logica para compartir
                    },
                    iconSize: 22,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
