import 'package:capstone/widgets/dashboard/welcome_offer_card.dart';
import 'package:capstone/widgets/dashboard/welcome_user_card.dart';
import 'package:flutter/material.dart';

class WelcomeCarousel extends StatelessWidget {
  const WelcomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        WelcomeUserCard(key: key),
        WelcomeOfferCard(key: key),
      ]),
    );
  }
}
