import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;

  const CategoryChips({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10.0,
        children: categories.map((category) {
          return Chip(
            label: Text(
              category,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          );
        }).toList(),
      ),
    );
  }
}
