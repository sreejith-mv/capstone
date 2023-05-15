import 'package:capstone/widgets/common/app_bar.dart';
import 'package:capstone/widgets/common/category_tile.dart';
import 'package:capstone/widgets/common/product_grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String path = 'category';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String categoryId = '';
  bool isAllChanged = false;
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    categoryId = !isAllChanged ? arguments['id'] : categoryId;
    return Scaffold(
      appBar: CapstoneAppBar(title: arguments['name'].toString()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            arguments['name'] == "All Categories"
                ? getCategoryList()
                : Container(),
            ProductGrid(categoryId: categoryId)
          ],
        ),
      ),
    );
  }

  getCategoryList() {
    final CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');

    return StreamBuilder(
      stream: categories.orderBy('order').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return SizedBox(
          height: 200,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            children: snapshot.data!.docs.map<Widget>((DocumentSnapshot doc) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: categoryId == doc.id
                        ? Colors.amber
                        : Colors.transparent),
                child: CategoryTile(
                  onTap: () {
                    setState(() {
                      categoryId = doc.id;
                      isAllChanged = true;
                    });
                  },
                  name: doc['name'],
                  id: doc.id,
                  icon: doc['icon'],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
