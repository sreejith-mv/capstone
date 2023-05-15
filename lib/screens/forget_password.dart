import 'package:capstone/widgets/common/elevated_button.dart';
import 'package:capstone/widgets/common/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _asyncFormErrorMessage = '';

  void _navigateToDashboard() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
            "Password reset link send to your email id ${_emailController.text}. Please check your mailbox."),
      ),
    );
    Navigator.pop(context);
  }

  _sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        _navigateToDashboard();
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == "user-not-found") {
          message = 'User not fount';
        } else {
          message =
              "Forget Password failed due to some technical issue. Please contact customer care";
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
        child: Form(
          key: _formKey,
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
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide an email';
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
                CapstoneElevatedButton(
                    text: 'Send Reset Password Link',
                    onPressed: () => _sendPasswordResetEmail()),
                const SizedBox(height: 16),
                _asyncFormErrorMessage.isNotEmpty
                    ? Text(_asyncFormErrorMessage,
                        style: const TextStyle(color: Colors.red))
                    : const Text(''),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an account?',
                      style: TextStyle(color: brandColor, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: brandColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
