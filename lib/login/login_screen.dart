import 'package:flutter/material.dart';
import '../component/moving_clouds.dart';
import '../components/apple_button.dart';
import '../components/google_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            const MovingClouds(), // Añade las nubes animadas al fondo
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30), // Añadir espacio superior
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 300,
                      width: 300,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Welcome back you\'ve been missed!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Sign in button Google
                    MyButtonGoogle(
                      onTap: () {}, // Mantener el botón, pero sin funcionalidad
                      imagePath: 'assets/images/google.png',
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Sign in button Apple
                    MyButtonApple(
                      onTap: () {}, // Mantener el botón, pero sin funcionalidad
                      imagePath: 'assets/images/apple.png',
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
