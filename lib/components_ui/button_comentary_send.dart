import 'package:flutter/material.dart';

class CommentSendButton extends StatefulWidget {
  final Function()? onPressed;
  final Color? backgroundColor;

  const CommentSendButton({
    Key? key,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _CommentSendButtonState createState() => _CommentSendButtonState();
}

class _CommentSendButtonState extends State<CommentSendButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value * 2.0 * 3.1415, // 360 degrees in radians
            child: FloatingActionButton(
              onPressed: () async {
                setState(() {
                  _controller.forward(from: 0.0); // Start animation from the beginning
                });
                if (widget.onPressed != null) {
                  await widget.onPressed!();
                }
                await Future.delayed(Duration(milliseconds: 500)); // Wait for animation to complete
                _controller.reverse();
              },
              child: Icon(Icons.send),
              shape: CircleBorder(),
              backgroundColor: widget.backgroundColor ?? Theme.of(context).primaryColor,
            ),
          );
        },
      ),
    );
  }
}
