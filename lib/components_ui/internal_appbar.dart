import 'package:flutter/material.dart';

class InternalAppBar extends StatelessWidget {
  const InternalAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('AppBar Sample'),

      notificationPredicate: (ScrollNotification notification) {
        return notification.depth == 1;
      },
      scrolledUnderElevation: 4.0,
      shadowColor: Theme.of(context).shadowColor,
      bottom: TabBar(
        tabs: <Widget>[
          Tab(
            icon: const Icon(Icons.cloud_outlined),
            text: 'Cloud',
          ),
          Tab(
            icon: const Icon(Icons.beach_access_sharp),
            text: 'Beach',
          ),
          Tab(
            icon: const Icon(Icons.brightness_5_sharp),
            text: 'Sunny',
          ),
        ],
      ),
    );
  }
}
