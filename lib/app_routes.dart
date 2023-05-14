import 'package:capstone/screens/dashboard.dart';
import 'package:capstone/screens/forget_password.dart';
import 'package:capstone/screens/login.dart';
import 'package:capstone/screens/onboarding.dart';
import 'package:capstone/screens/registration.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(settings) {
    switch (settings.name) {
      case '/onboarding':
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
          settings: settings,
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );
      case '/register':
        return MaterialPageRoute(
          builder: (context) => const RegistrationScreen(),
          settings: settings,
        );
      case '/dashboard':
        return MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
          settings: settings,
        );
      case '/forget-password':
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
          settings: settings,
        );
    }
  }
}
