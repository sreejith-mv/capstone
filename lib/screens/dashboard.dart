import 'package:capstone/widgets/common/app_bar.dart';
import 'package:capstone/widgets/dashboard/category_list.dart';
import 'package:capstone/widgets/dashboard/top_selling_grid.dart';
import 'package:capstone/widgets/dashboard/welcome_carousel.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  static const String path = 'dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CapstoneAppBar(title: 'Dashboard'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WelcomeCarousel(key: key),
            const SizedBox(height: 10),
            DashboardCategoryList(key: key),
            const SizedBox(height: 10),
            TopSellingGrid(key: key)
          ],
        ),
      ),
    );
  }
}
