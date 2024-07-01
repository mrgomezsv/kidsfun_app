import 'package:flutter/material.dart';

class InternalAppBar extends StatelessWidget {
  final String title;

  InternalAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(icon: Icon(Icons.photo), text: 'Gallery'),
        Tab(icon: Icon(Icons.video_collection), text: 'Video'),
        // Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Share'),
      ],
    );
  }
}
