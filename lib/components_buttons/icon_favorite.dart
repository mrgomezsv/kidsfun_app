import 'package:flutter/material.dart';

class FavoriteIcon extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  FavoriteIcon({required this.isFavorite, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: onFavoriteToggle,
      iconSize: 22,
    );
  }
}
