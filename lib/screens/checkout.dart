import 'package:capstone/widgets/checkout/billing_address.dart';
import 'package:capstone/widgets/checkout/checkout_button.dart';
import 'package:capstone/widgets/checkout/payment.dart';
import 'package:capstone/widgets/checkout/price_detail.dart';
import 'package:capstone/widgets/checkout/product_list.dart';
import 'package:capstone/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  static const String path = 'checkout';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CapstoneAppBar(title: 'Cart', showCart: false),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ProductList(),
            PriceDetail(),
            SizedBox(height: 10),
            BillingAddress(),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            PaymentList(),
            SizedBox(height: 10),
            Divider()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: CheckoutButton(),
      ),
    );
  }
}
