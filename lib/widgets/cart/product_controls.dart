import 'package:capstone/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartControls extends StatefulWidget {
  final Map<String, dynamic> product;
  final String id;
  final int quantity;
  const CartControls(
      {super.key,
      required this.quantity,
      required this.id,
      required this.product});

  @override
  State<CartControls> createState() => _CartControlsState();
}

class _CartControlsState extends State<CartControls> {
  int quantity = 0;
  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  _incasesQuantity() {
    setState(() {
      quantity = quantity + 1;
    });
    _updateQuantity();
  }

  _deceaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity = quantity - 1;
      });
      _updateQuantity();
    }
  }

  _updateQuantity() async {
    DocumentSnapshot cart = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (cart.exists) {
      final Map<String, dynamic> cartData = cart.data() as Map<String, dynamic>;
      final products = cartData['products'] ?? [];
      for (var i = 0; i < products.length; i++) {
        if (products[i]['id'] == widget.id) {
          products[i]['quantity'] = quantity;
        }
      }
      FirebaseFirestore.instance
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'products': products});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            quantityControl(_deceaseQuantity, Icons.remove),
            const SizedBox(width: 10),
            SizedBox(
                width: 20,
                child: Text(
                  widget.quantity.toString(),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(width: 10),
            quantityControl(_incasesQuantity, Icons.add),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          '\$${widget.product['price'] * widget.quantity}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  GestureDetector quantityControl(method, IconData icon) {
    return GestureDetector(
      onTap: method,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: brandColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
