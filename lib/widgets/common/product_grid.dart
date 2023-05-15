import 'package:capstone/models/product.dart';
import 'package:capstone/widgets/common/product_item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  final String categoryId;

  ProductGrid({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: categoryId != 'all'
          ? products.where('catagoryId', isEqualTo: categoryId).snapshots()
          : products.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: snapshot.data!.docs.map<Widget>((DocumentSnapshot doc) {
              return ProductItemCard(
                product: Product(
                  categoryId: doc['catagoryId'],
                  description: doc['description'],
                  image: doc['image'],
                  offerPrice: doc['offerPrice'],
                  price: doc['price'],
                  rating: doc['rating'],
                  topSelling: doc['topSelling'],
                  name: doc['name'],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
