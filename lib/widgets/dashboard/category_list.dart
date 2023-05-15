import 'package:capstone/widgets/common/category_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardCategoryList extends StatelessWidget {
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  final int limit;

  DashboardCategoryList({super.key, this.limit = 4});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: categories.orderBy('order').limit(limit).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return SizedBox(
          height: limit == 4 ? 100 : 200,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            children: snapshot.data!.docs.map<Widget>((DocumentSnapshot doc) {
              return CategoryTile(
                onTap: () {
                  Navigator.pushNamed(context, '/category',
                      arguments: {'id': doc.id, 'name': doc['name']});
                },
                name: doc['name'],
                id: doc.id,
                icon: doc['icon'],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
