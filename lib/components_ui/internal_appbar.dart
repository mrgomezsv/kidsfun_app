import 'package:flutter/material.dart';

class InternalAppBar extends StatelessWidget {
  final String title;

  InternalAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(
            icon: Icon(
              Icons.photo,
              size: 40,
            ),
            text: ''),
        Tab(
            icon: Icon(
                Icons.video_collection,
            size: 40,
            ), text: ''),
        // Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Share'),
      ],
    );
  }
}
