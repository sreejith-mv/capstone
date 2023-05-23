import 'package:accordion/accordion.dart';
import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:capstone/widgets/orders/order_list_header.dart';
import 'package:capstone/widgets/orders/price_detail.dart';
import 'package:capstone/widgets/orders/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  final dynamic orderList;
  const OrderList({super.key, this.orderList});

  Future<void> _showMyDialog(BuildContext context, num id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Order'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to cancel this order?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel Order'),
              onPressed: () {
                _updateQuantity(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _updateQuantity(id) async {
    DocumentSnapshot orders = await FirebaseFirestore.instance
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (orders.exists) {
      final Map<String, dynamic> orderData =
          orders.data() as Map<String, dynamic>;
      final orderList = orderData['orders'] ?? [];
      for (var i = 0; i < orderList.length; i++) {
        if (orderList[i]['id'] == id) {
          orderList[i]['status'] = 'Canceled';
        }
      }
      FirebaseFirestore.instance
          .collection('orders')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'orders': orderList});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Accordion(
        children: orderList.map<AccordionSection>((dynamic order) {
      print(order['status']);
      return AccordionSection(
        isOpen: true,
        headerBackgroundColor: brandColor,
        contentBorderColor: Colors.black54,
        header: OrderListHeader(order: order),
        content: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: order['products'].length,
              itemBuilder: (context, productIndex) {
                final product = order['products'][productIndex];
                return OrdersProductItem(id: product['id'], product: product);
              },
            ),
            PriceDetail(
              products: order['products'],
            ),
            (order['status'].toString().contains("Delivered") ||
                    order['status'].toString().contains("Canceled"))
                ? Container()
                : CapstoneDarkElevatedButton(
                    onPressed: () => _showMyDialog(context, order['id']),
                    text: 'Cancel Order')
          ],
        ),
      );
    }).toList());
  }
}
