import 'package:flutter/material.dart';
import '../navigation/my_app_bar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Login'),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/main');
          },
          child: Text('Iniciar sesión'),
        ),
      ),
    );
  }
}
