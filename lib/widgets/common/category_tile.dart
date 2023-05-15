import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String name;
  final String id;
  final String icon;
  final dynamic onTap;
  const CategoryTile(
      {super.key,
      required this.name,
      required this.id,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/$icon',
              width: 50,
            ),
            const SizedBox(height: 5),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
