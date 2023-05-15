import 'package:capstone/app_routes.dart';
import 'package:capstone/screens/dashboard.dart';
import 'package:capstone/screens/onboarding.dart';
import 'package:capstone/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  Application({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Capstone Fashion Store',
        theme: ThemeData(
          fontFamily: "LexendDeca",
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 0,
            iconTheme: IconThemeData(color: brandColor),
            titleTextStyle: TextStyle(
              fontSize: 24,
              color: brandColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: FutureBuilder(
          future: _auth.authStateChanges().first,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return DashboardScreen(key: key);
            } else {
              return OnboardingScreen(key: key);
            }
          },
        ),
        onGenerateRoute: (settings) => AppRoutes.routes(settings));
  }
}
