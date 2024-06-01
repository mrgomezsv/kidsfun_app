import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'main_screen.dart';
import 'product_screen.dart';
import 'ticket_screen.dart';
import 'profile_screen.dart';
import 'my_app_bar.dart';

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
        '/': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
        '/product': (context) => ProductScreen(),
        '/ticket': (context) => TicketScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
