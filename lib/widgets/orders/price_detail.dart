import 'package:flutter/material.dart';

class PriceDetail extends StatefulWidget {
  final List<dynamic> products;
  const PriceDetail({super.key, required this.products});

  @override
  State<PriceDetail> createState() => _PriceDetailState();
}

class _PriceDetailState extends State<PriceDetail> {
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    _totalPrice();
  }

  _totalPrice() async {
    double price = 0;
    for (var i = 0; i < widget.products.length; i++) {
      price = price +
          (widget.products[i]['quantity'] * widget.products[i]['price']);
      setState(() {
        totalPrice = price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 20,
          child: Text(
            'Gross Price: \$${totalPrice.toStringAsFixed(2)}',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 20,
          child: Text(
            'Tax(18%): \$${(totalPrice * .18).toStringAsFixed(2)}',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 20,
          child: Text(
            'Total Price: \$${((totalPrice * .18) + totalPrice).toStringAsFixed(2)}',
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
