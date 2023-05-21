import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckoutProductItem extends StatefulWidget {
  final Map<String, dynamic> product;
  final String id;
  const CheckoutProductItem(
      {super.key, required this.product, required this.id});

  @override
  State<CheckoutProductItem> createState() => _CheckoutProductItemState();
}

class _CheckoutProductItemState extends State<CheckoutProductItem> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    _getQuantity();
  }

  _getQuantity() async {
    DocumentSnapshot cart = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (cart.exists) {
      final Map<String, dynamic> cartData = cart.data() as Map<String, dynamic>;
      final products = cartData['products'] ?? [];
      for (var i = 0; i < products.length; i++) {
        if (products[i]['id'] == widget.id) {
          setState(() {
            quantity = products[i]['quantity'];
          });
        }
      }
      return 0;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                  '${widget.product['product']['name']}(${widget.product['size']})'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '\$${widget.product['price'].toString()}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  ),
                  Text(
                    ' x ',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(
                '\$${widget.product['price'] * quantity}',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        const Divider()
      ],
    );
  }
}
