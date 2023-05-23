import 'package:capstone/theme.dart';
import 'package:flutter/material.dart';

class CapstoneSearchTextField extends StatelessWidget {
  final TextEditingController controller;

  const CapstoneSearchTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: brandLight,
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: brandColor),
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            prefixIconColor: brandColor,
            border: InputBorder.none,
            focusColor: brandColor,
            hintText: 'Search Products',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.only(top: 15)),
      ),
    );
  }
}
