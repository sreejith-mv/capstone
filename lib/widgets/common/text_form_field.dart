import 'package:capstone/theme.dart';
import 'package:flutter/material.dart';

class CapstoneTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  const CapstoneTextFormField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.obscureText = false,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: brandColor),
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        style: const TextStyle(
          color: brandColor,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: brandColor,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        validator: validator,
      ),
    );
  }
}
