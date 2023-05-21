import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersProductItem extends StatelessWidget {
  final Map<String, dynamic> product;
  final String id;
  const OrdersProductItem({super.key, required this.product, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text('${product['product']['name']}(${product['size']})'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '\$${product['price'].toString()}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  ),
                  Text(
                    ' x ',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  ),
                  Text(
                    product['quantity'].toString(),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(
                '\$${product['price'] * product['quantity']}',
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
