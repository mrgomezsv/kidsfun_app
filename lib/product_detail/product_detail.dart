import 'package:flutter/material.dart';
import '../api_model/product_model.dart';
import 'image_carousel.dart';
import '../components_buttons/icon_comment.dart';
import '../components_buttons/icon_favorite.dart';
import '../components_buttons/icon_share.dart';


class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    String limitedTitle = widget.product.title.length > 16
        ? widget.product.title.substring(0, 16) + "..."
        : widget.product.title;

    Color titleColor = Colors.white; // Color por defecto para el texto del título
    if (Theme.of(context).appBarTheme.backgroundColor != null) {
      // Comprueba si hay un color de fondo definido en el tema de la AppBar
      Color backgroundColor = Theme.of(context).appBarTheme.backgroundColor!;
      // Determina si el fondo es claro u oscuro
      titleColor = backgroundColor.computeLuminance() > 0.5
          ? Colors.black // Si el fondo es claro, el texto será negro
          : Colors.white; // Si el fondo es oscuro, el texto será blanco
    }

    String shareText =
        '¡Mira este producto increíble! ${widget.product.title} ${widget.product.img}';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5.0), // Ajusta el espacio aquí
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8),
          child: Text(
            limitedTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold, // Establece el color del texto del título
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4 +
                  AppBar().preferredSize.height,
              width: double.infinity,
              child: Hero(
                tag: "productImage_${widget.product.id}",
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png', // Ruta de la imagen de placeholder
                  image: widget.product.img,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/placeholder.png',
                        fit: BoxFit.cover);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.mode_comment_outlined),
                                    onPressed: () {
                                      // Lógica para comentar
                                    },
                                  ),
                                  IconButton(
                                    icon: AnimatedBuilder(
                                      animation: _animationController,
                                      builder: (context, child) {
                                        return Icon(
                                          _isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: _isFavorite
                                              ? Colors.red
                                              : null,
                                        );
                                      },
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isFavorite = !_isFavorite;
                                        if (_isFavorite) {
                                          _animationController.forward();
                                        } else {
                                          _animationController.reverse();
                                        }
                                      });
                                    },
                                  ),
                                  ShareIcon(
                                    shareText: shareText,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Divider(color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            widget.product.description,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          ImageCarousel(
                            images: widget.product.additionalImages,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Comentarios',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Escribe tu comentario...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
