import 'package:flutter/cupertino.dart';

class MovingClouds extends StatefulWidget {
  const MovingClouds({Key? key}) : super(key: key);

  @override
  _MovingCloudsState createState() => _MovingCloudsState();
}

class _MovingCloudsState extends State<MovingClouds> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animation = Tween<double>(begin: 0, end: 2).animate(_controller)..addListener(() {
      setState(() {});
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned.fill(
          child: _buildCloud('assets/images/cloud1.png', 0, screenWidth, screenHeight * 0.2, isLeft: true),
        ),
        Positioned.fill(
          child: _buildCloud('assets/images/cloud2.png', 0, screenWidth, screenHeight * 0.25, isLeft: false),
        ),
        Positioned.fill(
          child: _buildCloud('assets/images/cloud1.png', 0, screenWidth, screenHeight * 0.3, isLeft: true),
        ),
        Positioned.fill(
          child: _buildCloud('assets/images/cloud2.png', 0, screenWidth, screenHeight * 0.35, isLeft: false),
        ),
      ],
    );
  }

  Widget _buildCloud(String asset, double top, double screenWidth, double height, {required bool isLeft}) {
    double width = screenWidth;
    double leftPosition = _animation.value * screenWidth;

    // Ajuste para que las nubes se superpongan
    if (!isLeft) {
      leftPosition -= screenWidth;
    }

    return Transform.translate(
      offset: Offset(leftPosition, top),
      child: Image.asset(
        asset,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
