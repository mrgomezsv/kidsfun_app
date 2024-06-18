import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;

  CategoryChips({required this.categories});

  @override
  Widget build(BuildContext context) {
    // Agregar la categoría "All" al inicio de la lista de categorías
    List<String> allCategories = ['All', ...categories];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: allCategories.map((category) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Chip(
              label: Text(
                category,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}
