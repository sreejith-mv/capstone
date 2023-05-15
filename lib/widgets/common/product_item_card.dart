import 'package:capstone/models/product.dart';
import 'package:capstone/screens/product.dart';
import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  final Product product;
  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, ProductScreen.path, arguments: product),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                    image: NetworkImage(product.image), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Text(
                  '\$${product.offerPrice}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 10),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
