import 'package:flutter/material.dart';
import '../api_model/product_model.dart';
import 'package:kidsfun/product_detail/product_detail.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          height: 250,
          child: Hero(
            tag: "productImage_${product.id}", // Asigna un identificador único
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png', // Ruta de la imagen de placeholder
                        image: product.img,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/placeholder.png', fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Visibility(
                      visible: false, // Cambia a true si deseas mostrar el texto
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: IconButton(
                          icon: Icon(Icons.mode_comment_outlined),
                          onPressed: () {
                            // Lógica para Comentar
                          },
                          iconSize: 22,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: onFavoriteToggle,
                          iconSize: 22,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            // Logica para compartir
                          },
                          iconSize: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
