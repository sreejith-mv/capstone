import 'package:capstone/widgets/common/shopping_cart_icon.dart';
import 'package:flutter/material.dart';

class CapstoneAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CapstoneAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        const ShoppingCartIcon(),
        IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, '/profile', (route) => false),
            icon: const Icon(Icons.person)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
