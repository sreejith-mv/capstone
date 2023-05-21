import 'package:capstone/screens/profile.dart';
import 'package:capstone/widgets/common/shopping_cart_icon.dart';
import 'package:flutter/material.dart';

class CapstoneAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCart;
  const CapstoneAppBar({super.key, required this.title, this.showCart = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        showCart ? const ShoppingCartIcon() : Container(),
        IconButton(
            onPressed: () => Navigator.pushNamed(context, ProfileScreen.path),
            icon: const Icon(Icons.person)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
