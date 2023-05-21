import 'package:capstone/screens/product.dart';
import 'package:capstone/theme.dart';
import 'package:flutter/material.dart';

class ClothSizeBox extends StatefulWidget {
  final OnSizeChange onSizeSelected;
  const ClothSizeBox({super.key, required this.onSizeSelected});

  @override
  State<ClothSizeBox> createState() => _ClothSizeBoxState();
}

class _ClothSizeBoxState extends State<ClothSizeBox> {
  String selectedSize = 'S';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Size',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              sizeBox('S'),
              const SizedBox(width: 10),
              sizeBox('M'),
              const SizedBox(width: 10),
              sizeBox('L'),
              const SizedBox(width: 10),
              sizeBox('XL'),
              const SizedBox(width: 10),
              sizeBox('XXL')
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector sizeBox(String size) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedSize = size;
        widget.onSizeSelected.call(size);
      }),
      child: Container(
        width: 40,
        decoration: BoxDecoration(
            color: selectedSize == size ? brandColor : brandLight,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        padding: const EdgeInsets.all(5),
        child: Text(size,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: selectedSize == size ? brandLight : brandColor)),
      ),
    );
  }
}
