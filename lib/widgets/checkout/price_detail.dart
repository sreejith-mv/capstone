import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PriceDetail extends StatefulWidget {
  const PriceDetail({super.key});

  @override
  State<PriceDetail> createState() => _PriceDetailState();
}

class _PriceDetailState extends State<PriceDetail> {
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
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: Text(
            'Gross Price: \$${totalPrice.toStringAsFixed(2)}',
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: Text(
            'Tax(18%): \$${(totalPrice * .18).toStringAsFixed(2)}',
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: Text(
            'Total Price: \$${((totalPrice * .18) + totalPrice).toStringAsFixed(2)}',
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
