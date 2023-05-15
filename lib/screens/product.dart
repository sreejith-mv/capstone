import 'package:capstone/models/product.dart';
import 'package:capstone/widgets/common/app_bar.dart';
import 'package:capstone/widgets/products/add_to_cart.dart';
import 'package:capstone/widgets/products/cloth_info_box.dart';
import 'package:capstone/widgets/products/description_box.dart';
import 'package:capstone/widgets/products/cloth_size_box.dart';
import 'package:capstone/widgets/products/image_container.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const String path = 'product';
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: const CapstoneAppBar(title: ''),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Stack(
              children: [
                ImageContainer(product: product),
                ClothInfoBox(product: product),
              ],
            ),
            const ClothSizeBox(),
            DescriptionBox(product: product),
            const AddToCart()
          ],
        ),
      ),
    );
  }
}
