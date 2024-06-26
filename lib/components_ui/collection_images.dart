import 'dart:async';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;

  ImageCarousel({required this.images});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  late Timer _timer;
  String _currentFullScreenImage = ''; // Variable para almacenar la imagen actual en pantalla completa

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _startTimer();
    // Establece la primera imagen en pantalla completa al inicio
    setState(() {
      _currentFullScreenImage = widget.images[_currentIndex];
    });
  }

  @override
  void dispose() {
    _stopTimer();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentIndex < widget.images.length - 1) {
        _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        _currentIndex++; // Actualizamos el índice para reflejar el cambio de imagen
        setState(() {
          _currentFullScreenImage = widget.images[_currentIndex]; // Actualizamos la imagen en pantalla completa
        });
      } else {
        _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        _currentIndex = 0; // Reiniciamos el índice al inicio
        setState(() {
          _currentFullScreenImage = widget.images[_currentIndex]; // Actualizamos la imagen en pantalla completa
        });
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Contenedor principal que contiene el carrusel de imágenes
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 240, // Altura del contenedor del carrusel
              // PageView.builder crea el carrusel de imágenes
              child: PageView.builder(
                itemCount: widget.images.length, // Número de imágenes en el carrusel
                controller: _pageController, // Controlador del PageView
                onPageChanged: (index) {
                  // Actualiza el índice actual cuando se cambia de página
                  setState(() {
                    _currentIndex = index;
                  });
                },
                // itemBuilder construye cada elemento del carrusel
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Muestra la imagen en pantalla completa al hacer clic
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FullScreenImage(imageUrl: widget.images[index])),
                      );
                    },
                    // AnimatedBuilder para aplicar animación a las imágenes
                    child: AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (_pageController.position.haveDimensions && _pageController.page != null) {
                          double pageValue = _pageController.page!;
                          value = pageValue - index;
                          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                        }
                        return Center(
                          child: SizedBox(
                            height: Curves.easeOut.transform(value) * 500,
                            width: Curves.easeOut.transform(value) * 500,
                            child: child,
                          ),
                        );
                      },
                      // FadeInImage para cargar la imagen con un placeholder
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png', // Ruta de la imagen de placeholder
                        image: widget.images[index], // URL de la imagen
                        fit: BoxFit.cover, // Ajuste de la imagen
                        imageErrorBuilder: (context, error, stackTrace) {
                          // Manejo de error en caso de que la imagen no se pueda cargar
                          return Image.asset('assets/images/placeholder.png', fit: BoxFit.cover);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 8), // Espacio entre el carrusel y los indicadores
        // Indicadores de páginas del carrusel
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length, (index) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blue : Colors.grey, // Cambia de color según el índice actual
              ),
            );
          }),
        ),
      ],
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: imageUrl, // Utilizamos Hero para una transición suave entre las pantallas
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ImageCarousel(
        images: [
          'https://via.placeholder.com/300',
          'https://via.placeholder.com/400',
          'https://via.placeholder.com/500',
          'https://via.placeholder.com/600',
        ],
      ),
    ),
  ));
}
