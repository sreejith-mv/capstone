import 'package:capstone/screens/card.dart';
import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: const Text(
            'Payment Method',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('cards')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error occurred");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final payment = snapshot.data!.data() != null
                  ? snapshot.data!.data() as Map<String, dynamic>
                  : {};

              if (payment.isEmpty) {
                return CapstoneDarkElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, CardScreen.path),
                    text: 'Add Payment Method');
              }

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: brandColor),
                            children: [
                              const TextSpan(
                                  text: 'Card Holder Name: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: payment['cardHolderName']),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: brandColor),
                            children: [
                              const TextSpan(
                                  text: 'Card Number: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      '${payment['cardNumber'].split(' ')[0]} XXXX XXXX ${payment['cardNumber'].split(' ')[3]}'),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: brandColor),
                            children: [
                              const TextSpan(
                                  text: 'Expiry Date: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: payment['expiryDate']),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: brandColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () =>
                            Navigator.pushNamed(context, CardScreen.path),
                        child: const Text('Edit'),
                      ),
                    )
                  ],
                ),
              );
            })
      ],
    );
  }
}
