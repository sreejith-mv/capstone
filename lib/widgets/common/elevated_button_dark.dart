import 'package:capstone/theme.dart';
import 'package:flutter/material.dart';

class CapstoneDarkElevatedButton extends StatelessWidget {
  final onPressed;
  final String text;
  const CapstoneDarkElevatedButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: brandColor,
            foregroundColor: brandLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
