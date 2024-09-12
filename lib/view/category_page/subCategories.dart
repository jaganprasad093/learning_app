import 'package:flutter/material.dart';

class Subcategories extends StatefulWidget {
  const Subcategories({super.key});

  @override
  State<Subcategories> createState() => _SubcategoriesState();
}

class _SubcategoriesState extends State<Subcategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subcategories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
