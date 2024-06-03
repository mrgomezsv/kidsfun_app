import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: widget.currentIndex.toDouble(), end: widget.currentIndex.toDouble()).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant MyBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controller.reset();
      _animation = Tween<double>(begin: oldWidget.currentIndex.toDouble(), end: widget.currentIndex.toDouble()).animate(_controller)
        ..addListener(() {
          setState(() {});
        });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(5.0), // Margen para separar la barra de los bordes de la pantalla
        height: 70, // Altura ajustada para evitar el desbordamiento
        decoration: BoxDecoration(
          color: Colors.blue, // Color de fondo azul
          borderRadius: BorderRadius.all(
            Radius.circular(30.0), // Bordes redondeados para la forma de cápsula
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(index),
                      child: Container(
                        alignment: Alignment.center,
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: _animation.value == index ? Colors.white : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: child,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                index == 0
                                    ? Icons.shopping_cart
                                    : index == 1
                                    ? Icons.local_offer
                                    : Icons.person,
                                size: 26,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                index == 0
                                    ? 'Cart'
                                    : index == 1
                                    ? 'Offers'
                                    : 'Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bottom Navigation Bar'),
        ),
        body: Center(
          child: Text('Content goes here'),
        ),
        bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            // Handle tab change
          },
        ),
      ),
    );
  }
}
