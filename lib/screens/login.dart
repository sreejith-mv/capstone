import 'package:capstone/screens/dashboard.dart';
import 'package:capstone/screens/forget_password.dart';
import 'package:capstone/screens/registration.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:capstone/widgets/common/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String path = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _asyncFormErrorMessage = '';
  void _navigateToDashboard() {
    Navigator.pushNamedAndRemoveUntil(
        context, DashboardScreen.path, (route) => false);
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _usernameController.text.trim(),
            password: _passwordController.text.trim());
        _navigateToDashboard();
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == "user-not-found") {
          message =
              'No account found with provided email. Please register are new user.';
        } else if (e.code == "wrong-password") {
          message = 'Wrong password';
        }
        setState(() => _asyncFormErrorMessage = message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    const Text(
                      'Welcome to Capstone',
                      style: TextStyle(color: brandColor, fontSize: 24),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Login to your account',
                      style: TextStyle(color: brandColor, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    CapstoneTextFormField(
                      hintText: 'Email',
                      controller: _usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide am email';
                        }
                        bool emailFormatValidation =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value);
                        if (!emailFormatValidation) {
                          return "Please provide valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CapstoneTextFormField(
                        hintText: 'Password',
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a Password';
                          }
                          return null;
                        }),
                    const SizedBox(height: 30),
                    CapstoneDarkElevatedButton(
                        text: 'Login', onPressed: () => _login()),
                    const SizedBox(height: 16),
                    _asyncFormErrorMessage.isNotEmpty
                        ? Text(_asyncFormErrorMessage,
                            style: const TextStyle(color: Colors.red))
                        : const Text(''),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Forgot password?',
                          style: TextStyle(color: brandColor, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                              context, ForgetPasswordScreen.path),
                          child: const Text(
                            'Reset',
                            style: TextStyle(
                                color: brandColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don’t have an account?',
                            style: TextStyle(color: brandColor, fontSize: 16)),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                              context, RegistrationScreen.path),
                          child: const Text('Sign up',
                              style: TextStyle(
                                  color: brandColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
