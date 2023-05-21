import 'package:capstone/widgets/cart/checkout_button.dart';
import 'package:capstone/widgets/cart/product_list.dart';
import 'package:capstone/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const String path = 'cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CapstoneAppBar(title: 'Cart', showCart: false),
      body: ProductList(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: CheckoutButton(),
      ),
    );
  }
}
