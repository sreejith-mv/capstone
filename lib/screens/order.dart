import 'package:capstone/widgets/orders/order_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/common/app_bar.dart';

class Orders extends StatelessWidget {
  static const String path = 'orders';
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CapstoneAppBar(title: 'Orders'),
      body: StreamBuilder(
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

            return OrderList(orderList: orderList);
          }),
    );
  }
}
