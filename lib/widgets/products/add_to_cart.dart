import 'package:capstone/models/product.dart';
import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  final String size;
  final Product product;
  const AddToCart({super.key, required this.size, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
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
        if (products[i]['id'] == widget.product.id) {
          // &&products[i]['size'] == widget.size) {
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
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: CapstoneDarkElevatedButton(
            onPressed: quantity > 0 ? null : onAddClick,
            text: quantity > 0 ? 'Added' : 'Add to Cart'));
  }

  void onAddClick() {
    if (quantity > 0) {
      return;
    }
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "products": FieldValue.arrayUnion([
        {
          'product': {
            'categoryId': widget.product.categoryId,
            'offerPrice': widget.product.offerPrice,
            'name': widget.product.name,
            'image': widget.product.image,
            'rating': widget.product.rating,
          },
          'id': widget.product.id,
          'size': widget.size,
          'price': widget.product.offerPrice,
          'quantity': 1
        }
      ])
    }, SetOptions(merge: true));
    setState(() {
      quantity = 1;
    });
  }
}
