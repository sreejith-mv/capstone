import 'package:accordion/accordion_section.dart';
import 'package:capstone/theme.dart';
import 'package:capstone/widgets/orders/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/common/app_bar.dart';
import '../widgets/orders/price_detail.dart';

class Orders extends StatelessWidget {
  static const String path = 'orders';
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CapstoneAppBar(title: 'Orders'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("orders")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error occurred");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final orders = snapshot.data!.data() as Map<String, dynamic>;

              if (orders.isEmpty) {
                return const Center(child: Text("No orders in placed."));
              }

              final orderList = orders['orders'] ?? [];

              return ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  final order = orderList[index];
                  return AccordionSection(
                    isOpen: true,
                    headerBackgroundColor: brandColor,
                    contentBorderColor: Colors.black54,
                    flipRightIconIfOpen: true,
                    header: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: 'Order Number: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: order['id'].toString())
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: 'Order Date: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: DateFormat('dd-MM-yyyy').format(
                                            (order['date'] as Timestamp)
                                                .toDate()))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            order['status'],
                            style: const TextStyle(
                                color: brandLight, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    content: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: order['products'].length,
                          itemBuilder: (context, productIndex) {
                            final product = order['products'][productIndex];
                            return OrdersProductItem(
                                id: product['id'], product: product);
                          },
                        ),
                        PriceDetail(
                          products: order['products'],
                        )
                      ],
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
