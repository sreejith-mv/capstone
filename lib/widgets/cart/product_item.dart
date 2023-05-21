import 'package:capstone/theme.dart';
import 'package:capstone/widgets/cart/product_controls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProductItem extends StatefulWidget {
  final Map<String, dynamic> product;
  final String id;
  const CartProductItem({super.key, required this.product, required this.id});

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
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
        ListTile(
          title: Text(widget.product['product']['name']),
          subtitle: Text('Size: ${widget.product['size']}'),
          leading: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.product['product']['image']),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
            ),
          ),
          trailing: CartControls(
            quantity: quantity,
            product: widget.product,
            id: widget.id,
          ),
        ),
        const Divider()
      ],
    );
  }
}
