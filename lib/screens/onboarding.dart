import 'package:capstone/screens/login.dart';
import 'package:capstone/widgets/common/elevated_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const String path = 'onboarding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/onboarding.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 47.0, right: 47.0),
                child: Text(
                  'Create your own style now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 47.0, right: 47.0, top: 24, bottom: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet consectetur augue nibh molestie varius miadipiscing. Velit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CapstoneElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, LoginScreen.path),
                    text: 'Start Shopping'),
              )
            ],
          ),
        )
      ]),
    );
  }
}
