import 'package:capstone/models/product.dart';
import 'package:capstone/widgets/common/product_item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopSellingGrid extends StatelessWidget {
  TopSellingGrid({super.key});
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: categories.where('topSelling', isEqualTo: true).snapshots(),
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
                  id: doc.id,
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
