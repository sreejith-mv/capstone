import 'package:capstone/widgets/cart/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("cart")
          .doc(user!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error occurred");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        print(snapshot.data);
        print(snapshot.data!.data());
        final cartItems = snapshot.data!.data() as Map<String, dynamic>;

        if (cartItems == null || cartItems.isEmpty) {
          return const Text("No item in cart.");
        }

        final products = cartItems['products'] ?? [];

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return CartProductItem(
                      id: product['id'],
                      product: product,
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
