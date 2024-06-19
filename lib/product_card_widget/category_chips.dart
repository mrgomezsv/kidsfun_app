import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String?) onSelectCategory;

  CategoryChips({
    required this.categories,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    List<String> allCategories = ['All', ...categories];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: allCategories.map((category) {
          bool isAllCategory = category == 'All';
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Container(
                padding: isAllCategory ? EdgeInsets.symmetric(horizontal: 15.0) : EdgeInsets.zero, // Añadir padding horizontal solo para "All"
                child: Text(
                  category,
                  style: TextStyle(
                    color: Colors.white, // Color del texto
                  ),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor, // Color de fondo del chip
              selected: selectedCategory == category,
              selectedColor: Theme.of(context).colorScheme.secondary, // Color de fondo cuando está seleccionado
              onSelected: (isSelected) {
                onSelectCategory(isSelected ? category : null);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
