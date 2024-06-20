import 'package:flutter/material.dart';
import '../api_model/product_model.dart';
import '../components_ui/comentary_bottom_sheet.dart';
import 'image_carousel.dart';
import '../components_ui/icon_comment.dart';
import '../components_ui/icon_favorite.dart';
import '../components_ui/icon_share.dart';

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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCommentField() {
    // Añadir un delay para asegurarnos de que el contenido está renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String limitedTitle = widget.product.title.length > 16
        ? widget.product.title.substring(0, 16) + "..."
        : widget.product.title;

    Color titleColor = Colors.white;
    if (Theme.of(context).appBarTheme.backgroundColor != null) {
      Color backgroundColor = Theme.of(context).appBarTheme.backgroundColor!;
      titleColor = backgroundColor.computeLuminance() > 0.5
          ? Colors.black
          : Colors.white;
    }

    String shareText =
        '¡Mira este producto increíble! ${widget.product.title} ${widget.product.img}';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
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
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
                  placeholder: 'assets/images/placeholder.png',
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
                                    //onPressed: _scrollToCommentField,
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ComentaryBottomSheet();
                                        },
                                      );
                                    }
                                  ),
                                  IconButton(
                                    icon: AnimatedBuilder(
                                      animation: _animationController,
                                      builder: (context, child) {
                                        return Icon(
                                          _isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: _isFavorite ? Colors.red : null,
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
