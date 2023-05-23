import 'package:capstone/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListHeader extends StatelessWidget {
  final dynamic order;
  const OrderListHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: DateFormat('dd-MM-yyyy')
                            .format((order['date'] as Timestamp).toDate()))
                  ],
                ),
              ),
            ],
          ),
          Text(
            order['status'],
            style:
                const TextStyle(color: brandLight, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
