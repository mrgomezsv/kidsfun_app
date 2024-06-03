import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenImage({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: PageView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.network(images[index], fit: BoxFit.contain);
            },
            controller: PageController(initialPage: initialIndex),
          ),
        ),
      ),
    );
  }
}
