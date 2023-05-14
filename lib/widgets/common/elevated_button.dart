import 'package:capstone/theme.dart';
import 'package:flutter/material.dart';

class CapstoneElevatedButton extends StatelessWidget {
  final onPressed;
  final String text;
  const CapstoneElevatedButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: brandColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
