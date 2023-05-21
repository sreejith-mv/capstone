import 'dart:math';

import 'package:capstone/screens/dashboard.dart';
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
  bool enableButton = false;

  @override
  void initState() {
    super.initState();

    _isEnableButton();
  }

  Future<bool> _isCardAdded() async {
    DocumentSnapshot card = await FirebaseFirestore.instance
        .collection('cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return card.exists ? true : false;
  }

  Future<bool> _isAddressAdded() async {
    DocumentSnapshot address = await FirebaseFirestore.instance
        .collection('address')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return address.exists ? true : false;
  }

  Future<bool> _isCardItemAdded() async {
    DocumentSnapshot carts = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return carts.exists ? true : false;
  }

  Future<void> _isEnableButton() async {
    final bool isAddressAdded = await _isAddressAdded();
    final bool isCardAdded = await _isCardAdded();
    final bool isCardItemAdded = await _isCardItemAdded();
    if (isCardAdded && isAddressAdded && isCardItemAdded) {
      setState(() {
        enableButton = true;
      });
    }
  }

  Future<void> _placeOrder() async {
    DocumentSnapshot cart = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (cart.exists) {
      final Map<String, dynamic> cartData = cart.data() as Map<String, dynamic>;
      final products = cartData['products'] ?? [];
      Random random = new Random();
      int orderNumber = random.nextInt(10000);

      FirebaseFirestore.instance
          .collection("orders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "orders": FieldValue.arrayUnion([
          {
            "id": orderNumber,
            "products": products,
            "date": DateTime.now(),
            'status': 'Order Placed'
          },
        ])
      }, SetOptions(merge: true));
      FirebaseFirestore.instance
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
      Navigator.pushNamedAndRemoveUntil(
          context, DashboardScreen.path, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CapstoneDarkElevatedButton(
        onPressed: () => enableButton ? _placeOrder() : null,
        text: 'Place Order');
  }
}
