import 'package:capstone/theme.dart';
import 'package:capstone/widgets/cart/product_controls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProductItem extends StatelessWidget {
  final Map<String, dynamic> product;
  const CartProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(product['product']['name']),
          subtitle: Text('Size: ${product['size']}'),
          leading: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(product['product']['image']),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
            ),
          ),
          trailing:
              CartControls(quantity: product['quantity'], product: product),
        ),
        const Divider()
      ],
    );
  }
}
