import 'package:flutter/material.dart';

class DropDownTextField extends StatefulWidget {
  const DropDownTextField({super.key});

  @override
  State<DropDownTextField> createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  String? _selectedIngredient;
  // Variable to hold the selected ingredient
  final List<String> ingredients = [
    'Ingredient 1',
    'Ingredient 2',
    'Ingredient 3',
    'Ingredient 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: DropdownButton(
        value: _selectedIngredient,
        hint: const Text(
          "Select an active ingredient",
          style: TextStyle(
            color: Color.fromRGBO(
              102,
              102,
              102,
              .74,
            ),
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down),
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            _selectedIngredient = newValue;
          });
        },
        items: ingredients.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}