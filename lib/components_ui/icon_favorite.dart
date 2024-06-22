import 'package:flutter/material.dart';

class FavoriteIcon extends StatefulWidget {
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;

  FavoriteIcon({required this.isFavorite, required this.onFavoriteChanged});

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon>
    with SingleTickerProviderStateMixin {
  late bool _isFavorite;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
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
