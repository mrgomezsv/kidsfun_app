import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final String? userName;
  final String? userPhotoUrl;

  UserInfoWidget({this.userName, this.userPhotoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: userPhotoUrl != null
                ? NetworkImage(userPhotoUrl!)
                : AssetImage('assets/images/user_profile.jpeg'),
          ),
          SizedBox(width: 10),
          Text(
            userName ?? "Nombre del Usuario",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
