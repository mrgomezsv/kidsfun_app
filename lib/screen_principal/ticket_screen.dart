import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../user_date/UserInfoWidget.dart'; // Asegúrate de que la ruta sea correcta según la estructura de tus carpetas

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  String? _userName;
  String? _userPhotoUrl;

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
        _userPhotoUrl = user.photoURL;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserInfoWidget(
            userName: _userName,
            userPhotoUrl: _userPhotoUrl,
          ),
          Expanded(
            child: Center(
              child: Text('Ticket Screen'),
            ),
          ),
        ],
      ),
    );
  }
}
