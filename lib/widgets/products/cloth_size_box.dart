import 'package:capstone/theme.dart';
import 'package:flutter/material.dart';

class ClothSizeBox extends StatefulWidget {
  const ClothSizeBox({
    super.key,
  });

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
              GestureDetector(
                onTap: () => setState(() {
                  selectedSize = 'S';
                }),
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                      color: selectedSize == 'S' ? brandColor : brandLight,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'S',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selectedSize == 'S' ? brandLight : brandColor),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() {
                  selectedSize = 'M';
                }),
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                      color: selectedSize == 'M' ? brandColor : brandLight,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'M',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selectedSize == 'M' ? brandLight : brandColor),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() {
                  selectedSize = 'L';
                }),
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                      color: selectedSize == 'L' ? brandColor : brandLight,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'L',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selectedSize == 'L' ? brandLight : brandColor),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() {
                  selectedSize = 'XL';
                }),
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                      color: selectedSize == 'XL' ? brandColor : brandLight,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'XL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selectedSize == 'XL' ? brandLight : brandColor),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() {
                  selectedSize = 'XXL';
                }),
                child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                      color: selectedSize == 'XXL' ? brandColor : brandLight,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'XXL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selectedSize == 'XXL' ? brandLight : brandColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
