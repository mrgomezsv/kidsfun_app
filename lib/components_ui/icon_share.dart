import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareIcon extends StatelessWidget {
  final String shareText;

  ShareIcon({required this.shareText});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.share),
      onPressed: () {
        Share.share(shareText);
      },
      iconSize: 22,
    );
  }
}
