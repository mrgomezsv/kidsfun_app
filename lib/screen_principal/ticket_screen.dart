import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // AppBar(
          //   title: Text('Ticket Screen'), // Título del AppBar para la pantalla de tickets
          //   backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Color de fondo del AppBar
          // ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary, // Aplicando el mismo color que el AppBar
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30, // Tamaño del círculo de la foto del usuario
                  backgroundImage: AssetImage('assets/images/user_profile.jpeg'), // Placeholder de la imagen del usuario
                ),
                SizedBox(width: 10),
                Text(
                  'Nombre del Usuario',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Ticket Screen'), // Contenido de la pantalla de tickets
            ),
          ),
        ],
      ),
    );
  }
}
