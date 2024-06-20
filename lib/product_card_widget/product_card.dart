import 'package:flutter/material.dart';
import '../api_model/product_model.dart';
import 'package:kidsfun/product_detail/product_detail.dart';
import '../components_ui/comentary_bottom_sheet.dart';
import '../components_ui/icon_comment.dart';
import '../components_ui/icon_favorite.dart';
import '../components_ui/icon_share.dart';

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
    String shareText = '¡Mira este producto increíble! ${product.title} ${product.img}';

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
            tag: "productImage_${product.id}",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png',
                        image: product.img,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: CommentIcon(
                          onPressed: () {
                            // Lógica para Comentar
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return ComentaryBottomSheet();
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: FavoriteIcon(
                          isFavorite: isFavorite,
                          onFavoriteToggle: onFavoriteToggle,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: ShareIcon(
                          shareText: shareText,
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
