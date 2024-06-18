import 'package:flutter/material.dart';

class ShareIcon extends StatelessWidget {
  final VoidCallback onPressed;

  ShareIcon({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.share),
      onPressed: onPressed,
      iconSize: 22,
    );
  }
}
