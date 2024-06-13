import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/login_screen.dart'; // Asegúrate de importar LoginPage si no lo has hecho

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _userName;
  String? _userEmail;
  String? _userPhotoUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userName = user.displayName;
        _userEmail = user.email;
        _userPhotoUrl = user.photoURL;
      });
    }
  }

  Future<void> _signOutAndNavigateToLogin() async {
    setState(() {
      _isLoading = true; // Mostrar el spinner
    });
    await FirebaseAuth.instance.signOut();
    // Esperar 2 segundos
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false; // Ocultar el spinner
    });
    // Navegar a la página de inicio de sesión (LoginPage)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Elimina el transitionsBuilder para quitar el efecto de transición
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Mostrar el spinner si _isLoading es true
            : SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_userPhotoUrl ?? 'assets/images/user_profile.jpeg'),
              ),
              SizedBox(height: 20),
              Text(
                _userName ?? 'Nombre de usuario',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                _userEmail ?? 'usuario@ejemplo.com',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Divider(),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Información de la Cuenta'),
                onTap: () {
                  // Navegar a la pantalla de información de la cuenta
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notificaciones'),
                onTap: () {
                  // Navegar a la pantalla de configuración de notificaciones
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signOutAndNavigateToLogin,
                child: Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
