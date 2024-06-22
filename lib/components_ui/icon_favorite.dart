import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class _FavoriteIconState extends State<FavoriteIcon>
    with SingleTickerProviderStateMixin {
  late bool _isFavorite;
  late AnimationController _animationController;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
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
          print(
              '###################################################################');
          debugPrint('Favorite state: $_isFavorite');
          debugPrint('User ID: $_userId');
          debugPrint('Product ID: ${widget.productId}');
          print(
              '###################################################################');
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
