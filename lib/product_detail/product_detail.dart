import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../components_ui/button_comentary_send.dart';
import '../apis/commentary/comment_model.dart';
import '../apis/commentary/comment_api.dart';
import '../apis/products/product_model.dart';
import '../components_ui/collection_videos.dart';
import '../components_ui/comentary_bottom_sheet.dart';
import '../components_ui/collection_images.dart';
import '../components_ui/icon_comment.dart';
import '../components_ui/icon_favorite.dart';
import '../components_ui/icon_share.dart';
import '../components_ui/comment_body.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isFavorite = false;
  late ScrollController _scrollController;
  List<Comment> _comments = [];
  double _rotationAngle = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fetchComments();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCommentField() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _fetchComments() async {
    try {
      final comments = await CommentApi.fetchComments(widget.product.id);
      setState(() {
        _comments = comments;
      });
    } catch (e) {
      print('Failed to load comments: $e');
    }
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                padding: const EdgeInsets.all(5.0),
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
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ComentaryBottomSheet(
                                                productId: widget.product.id.toString());
                                          },
                                        ).then((_) {
                                          setState(() {
                                            _fetchComments();
                                          });
                                        });
                                      },
                                    ),
                                    FavoriteIcon(
                                      isFavorite: _isFavorite,
                                      onFavoriteChanged: (bool isFavorite) {
                                        setState(() {
                                          _isFavorite = isFavorite;
                                        });
                                      },
                                      productId: widget.product.id.toString(),
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
                            Divider(color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.photo, size: 40),
                      text: '',
                    ),
                    Tab(
                      icon: Icon(Icons.video_collection, size: 40),
                      text: '',
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 1),
                height: MediaQuery.of(context).size.height * 0.4,
                child: TabBarView(
                  children: [
                    ImageCarousel(
                      images: widget.product.additionalImages,
                    ),
                    Center(
                      child: YouTubePlayerWidget(videoUrl: 'https://www.youtube.com/watch?v=5qap5aO4i9A'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          _comments.isEmpty
                              ? 'Be the first to leave a comment!'
                              : 'Comments',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (_comments.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'This product has no comments yet. Be the first to leave one!',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ..._comments.map((comment) => CommentBody(comment: comment)).toList(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25.0, top: 15),
                child: CommentSendButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ComentaryBottomSheet(
                            productId: widget.product.id.toString());
                      },
                    ).then((_) {
                      setState(() {
                        _fetchComments();
                      });
                    });
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
