import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../apis/favorite/favorite_api.dart';
import '../apis/favorite/favorite_model.dart';

class FavoriteIcon extends StatefulWidget {
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;
  final String productId;

  FavoriteIcon({
    required this.isFavorite,
    required this.onFavoriteChanged,
    required this.productId,
  });

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> with SingleTickerProviderStateMixin {
  late bool _isFavorite;
  late AnimationController _animationController;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _getUserId();
  }

  void _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  void _sendFavorite(Favorite favorite) async {
    try {
      final response = await FavoriteApi.sendFavorite(favorite);

      if (response.statusCode == 201) {
        // Successfully sent favorite
        print('Favorite sent successfully');
      } else {
        // Error sending favorite
        print('Error sending favorite: ${response.body}');
      }
    } catch (e) {
      // Connection error or other error
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : null,
          );
        },
      ),
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
          widget.onFavoriteChanged(_isFavorite);

          // Create instance of Favorite
          Favorite newFavorite = Favorite(
            userId: _userId,
            productId: widget.productId,
            isFavorite: _isFavorite,
          );

          // Print statements for debugging
          print('Favorite state: $_isFavorite');
          print('User ID: $_userId');
          print('Product ID: ${widget.productId}');

          // Call API to send favorite
          _sendFavorite(newFavorite);

          if (_isFavorite) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        });
      },
    );
  }
}
