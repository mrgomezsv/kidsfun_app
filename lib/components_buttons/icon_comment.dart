import 'package:flutter/material.dart';

class CommentIcon extends StatelessWidget {
  final VoidCallback onPressed;

  CommentIcon({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.mode_comment_outlined),
      onPressed: onPressed,
      iconSize: 22,
    );
  }
}
