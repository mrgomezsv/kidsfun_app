import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../animation/moving_clouds.dart';
import '../components_ui/button_google.dart';
import '../home/main_screen.dart'; // Importa MainScreen para la redirección después del inicio de sesión
import '../onboarding/onboarding.dart'; // Importa OnboardingScreen para la redirección si no se ha completado el onboarding

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  Future<User?> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null)
      return null; // El usuario canceló el inicio de sesión

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Guardar el estado de sesión usando shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'isLoggedIn', true); // Guardar que el usuario ha iniciado sesión

    // Verificar si el usuario ha completado el onboarding
    bool hasCompletedOnboarding =
        prefs.getBool('hasCompletedOnboarding') ?? false;

    if (!hasCompletedOnboarding) {
      // Si no ha completado el onboarding, dirigirlo a OnboardingScreen
      await prefs.setBool('hasCompletedOnboarding',
          true); // Marcar que el onboarding ha sido completado
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else {
      // Si ha completado el onboarding, dirigirlo a MainScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }

    return userCredential.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            const MovingClouds(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_login.png',
                      height: 300,
                      width: 300,
                    ),
                    const SizedBox(height: 130),
                    Text(
                      'Welcome back you\'ve been missed!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyButtonGoogle(
                      onTap: () async {
                        User? user = await signInWithGoogle(context);
                        if (user != null) {
                          // No se necesita redirección directa aquí debido a la lógica de signInWithGoogle
                        }
                      },
                      imagePath: 'assets/images/google.png',
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Powered by mrgomez.dev',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
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
