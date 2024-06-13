import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../animation/moving_clouds.dart';
import '../components_buttons/apple_button.dart';
import '../components_buttons/google_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null; // El usuario canceló el inicio de sesión

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
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
                      'assets/images/logo.png',
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
                    //const SizedBox(height: 25),
                    // MyButtonGoogle(
                    //   onTap: () async {
                    //     User? user = await signInWithGoogle();
                    //     if (user != null) {
                    //       Navigator.pushNamed(context, '/onboarding');
                    //     }
                    //   },
                    //   imagePath: 'assets/images/google.png',
                    // ),
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
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          //   child: Text(
                          //     'Or continue with',
                          //     style: TextStyle(color: Colors.grey[700]),
                          //   ),
                          // ),
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
                    // MyButtonApple(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, '/onboarding');
                    //   },
                    //   imagePath: 'assets/images/apple.png',
                    // ),
                    MyButtonGoogle(
                      onTap: () async {
                        User? user = await signInWithGoogle();
                        if (user != null) {
                          Navigator.pushNamed(context, '/onboarding');
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
