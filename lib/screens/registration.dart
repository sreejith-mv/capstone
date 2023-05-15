import 'package:capstone/screens/login.dart';
import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/elevated_button.dart';
import 'package:capstone/widgets/common/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String path = 'registration';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _asyncFormErrorMessage = '';

  void _backToLogin() {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.path, (route) => false);
  }

  _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.value.text.trim(),
                password: _passwordController.value.text.trim());

        await userCredential.user!.updateDisplayName(_firstNameController.text);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(
          {
            "firstName": _firstNameController.text,
            "lastName": _lastNameController.text,
            "email": _emailController.text
          },
        );
        _backToLogin();
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == "weak-password") {
          message = "Provided Password is week";
        } else if (e.code == "email-already-in-use") {
          message = "Email is already in use";
        } else {
          message =
              "Registration failed due to some technical issue. Please contact customer care";
        }

        setState(() {
          _asyncFormErrorMessage = message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
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
                  'Sign up to your account',
                  style: TextStyle(color: brandColor, fontSize: 16),
                ),
                const SizedBox(height: 30),
                CapstoneTextFormField(
                  hintText: "First Name",
                  controller: _firstNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a First Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CapstoneTextFormField(
                  hintText: "Last Name",
                  controller: _lastNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a Last Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CapstoneTextFormField(
                  hintText: "Email ID/Phone Number",
                  controller: _emailController,
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
                  hintText: "Password",
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CapstoneTextFormField(
                  hintText: "Re-enter Password",
                  controller: _reEnterPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CapstoneElevatedButton(
                  text: 'Create',
                  onPressed: () => _register(),
                ),
                const SizedBox(height: 16),
                _asyncFormErrorMessage.isNotEmpty
                    ? Text(
                        _asyncFormErrorMessage,
                        style: const TextStyle(color: Colors.red),
                      )
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
