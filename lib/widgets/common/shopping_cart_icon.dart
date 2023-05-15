import 'package:capstone/screens/cart.dart';
import 'package:capstone/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShoppingCartIcon extends StatefulWidget {
  const ShoppingCartIcon({super.key});

  @override
  State<ShoppingCartIcon> createState() => _ShoppingCartIconState();
}

class _ShoppingCartIconState extends State<ShoppingCartIcon> {
  num count = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.exists) {
              final Map<String, dynamic> cartData =
                  snapshot.data!.data() as Map<String, dynamic>;
              final products = cartData['products'] ?? [];
              setState(() => count = products.length);
            }
          }
          return Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.path);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  constraints:
                      const BoxConstraints(minHeight: 20, minWidth: 20),
                  child: Text(count.toString(),
                      style: const TextStyle(color: brandLight, fontSize: 9),
                      textAlign: TextAlign.center),
                ),
              )
            ],
          );
        });
  }
}
