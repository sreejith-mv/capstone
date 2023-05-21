import 'package:capstone/screens/address.dart';
import 'package:capstone/screens/card.dart';
import 'package:capstone/screens/cart.dart';
import 'package:capstone/screens/category.dart';
import 'package:capstone/screens/checkout.dart';
import 'package:capstone/screens/dashboard.dart';
import 'package:capstone/screens/forget_password.dart';
import 'package:capstone/screens/login.dart';
import 'package:capstone/screens/onboarding.dart';
import 'package:capstone/screens/order.dart';
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
      case CheckoutScreen.path:
        return MaterialPageRoute(
          builder: (context) => const CheckoutScreen(),
          settings: settings,
        );
      case CardScreen.path:
        return MaterialPageRoute(
          builder: (context) => const CardScreen(),
          settings: settings,
        );

      case AddressScreen.path:
        return MaterialPageRoute(
          builder: (context) => const AddressScreen(),
          settings: settings,
        );
      case Orders.path:
        return MaterialPageRoute(
          builder: (context) => const Orders(),
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
