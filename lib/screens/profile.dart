import 'package:capstone/screens/onboarding.dart';
import 'package:capstone/widgets/checkout/billing_address.dart';
import 'package:capstone/widgets/checkout/payment.dart';
import 'package:capstone/widgets/common/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const String path = 'profile';
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CapstoneAppBar(
        title: '',
        showProfile: false,
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, OnboardingScreen.path, (route) => false);
              },
              child: const Text('Logout'),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error occurred");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final user = snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Image.asset('assets/images/profile.png', width: 140),
                      const SizedBox(height: 12),
                      Text(
                        '${user['firstName']} ${user['lastName']}',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user['email'],
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  );
                }),
            const SizedBox(height: 30),
            const BillingAddress(),
            const SizedBox(height: 30),
            const PaymentList(),
          ],
        ),
      ),
    );
  }
}
