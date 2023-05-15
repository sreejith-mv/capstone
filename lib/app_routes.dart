import 'package:capstone/screens/cart.dart';
import 'package:capstone/screens/category.dart';
import 'package:capstone/screens/dashboard.dart';
import 'package:capstone/screens/forget_password.dart';
import 'package:capstone/screens/login.dart';
import 'package:capstone/screens/onboarding.dart';
import 'package:capstone/screens/product.dart';
import 'package:capstone/screens/profile.dart';
import 'package:capstone/screens/registration.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(settings) {
    switch (settings.name) {
      case OnboardingScreen.path:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
          settings: settings,
        );
      case LoginScreen.path:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );
      case RegistrationScreen.path:
        return MaterialPageRoute(
          builder: (context) => const RegistrationScreen(),
          settings: settings,
        );
      case DashboardScreen.path:
        return MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
          settings: settings,
        );
      case CartScreen.path:
        return MaterialPageRoute(
          builder: (context) => const CartScreen(),
          settings: settings,
        );
      case ProductScreen.path:
        return MaterialPageRoute(
          builder: (context) => const ProductScreen(),
          settings: settings,
        );
      case CategoryScreen.path:
        return MaterialPageRoute(
          builder: (context) => const CategoryScreen(),
          settings: settings,
        );
      case ProfileScreen.path:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
          settings: settings,
        );
      case ForgetPasswordScreen.path:
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
