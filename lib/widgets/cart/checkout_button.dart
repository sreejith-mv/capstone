import 'package:capstone/screens/checkout.dart';
import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatefulWidget {
  const CheckoutButton({
    super.key,
  });

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    _totalPrice();
  }

  _totalPrice() async {
    DocumentSnapshot cart = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (cart.exists) {
      double price = 0;
      final Map<String, dynamic> cartData = cart.data() as Map<String, dynamic>;
      final products = cartData['products'] ?? [];
      for (var i = 0; i < products.length; i++) {
        price = price + (products[i]['quantity'] * products[i]['price']);
        setState(() {
          totalPrice = price;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CapstoneDarkElevatedButton(
        onPressed: () => Navigator.pushNamed(context, CheckoutScreen.path),
        text: 'Checkout (Total: ${totalPrice.toStringAsFixed(2)})');
  }
}
