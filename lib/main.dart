import 'package:flutter/material.dart';
import 'login/login_screen.dart';
import 'home/main_screen.dart';
import 'screen_principal/product_screen.dart';
import 'screen_principal/ticket_screen.dart';
import 'screen_principal/profile_screen.dart';
import 'navigation/my_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/main': (context) => MainScreen(),
        '/product': (context) => ProductScreen(),
        '/ticket': (context) => TicketScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
