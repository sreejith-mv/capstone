import 'package:capstone/app_routes.dart';
import 'package:capstone/screens/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  Application({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Capstone Fashion Store',
        theme: ThemeData(fontFamily: "LexendDeca"),
        home: FutureBuilder(
          future: _auth.authStateChanges().first,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              // return Dashboard(key: key);
              return OnboardingScreen(key: key);
            } else {
              return OnboardingScreen(key: key);
            }
          },
        ),
        onGenerateRoute: (settings) => AppRoutes.routes(settings));
  }
}
