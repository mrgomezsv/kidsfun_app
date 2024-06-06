import 'package:flutter/material.dart';
import 'package:kidsfun/login/login_screen.dart';
import '../login/login_screen.dart'; // Asegúrate de importar LoginPage si no lo has hecho


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user_profile.jpeg'),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre de usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'usuario@ejemplo.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la página de inicio de sesión (LoginPage) con una animación de desvanecimiento
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => LoginPage(),
                    transitionsBuilder: (context, animation1, animation2, child) {
                      return FadeTransition(opacity: animation1, child: child);
                    },
                    transitionDuration: Duration(milliseconds: 500),
                  ),
                );
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
