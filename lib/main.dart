import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/main_screen.dart';
import 'login/login_screen.dart';
import 'onboarding/onboarding.dart'; // Importa el archivo onboarding.dart
import 'screen_principal/product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    hasCompletedOnboarding: hasCompletedOnboarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool hasCompletedOnboarding;

  const MyApp({
    Key? key,
    required this.isLoggedIn,
    required this.hasCompletedOnboarding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Verificar si el usuario está logeado y si ha completado el onboarding
    if (isLoggedIn && hasCompletedOnboarding) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF118AB2)),
          useMaterial3: true,
        ),
        home: MainScreen(),
        routes: {
          '/product': (context) => ProductScreen(),
          '/main': (context) => MainScreen(),
          '/onboarding': (context) => OnboardingScreen(),
        },
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF118AB2)),
          useMaterial3: true,
        ),
        home: isLoggedIn ? OnboardingScreen() : LoginPage(),
        routes: {
          '/product': (context) => ProductScreen(),
          '/main': (context) => MainScreen(),
          '/onboarding': (context) => OnboardingScreen(),
        },
      );
    }
  }
}
