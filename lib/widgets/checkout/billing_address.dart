import 'package:capstone/screens/address.dart';
import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BillingAddress extends StatelessWidget {
  const BillingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: const Text(
            'Billing Address',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('address')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error occurred");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final address = snapshot.data!.data() != null
                  ? snapshot.data!.data() as Map<String, dynamic>
                  : {};

              if (address.isEmpty) {
                return CapstoneDarkElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AddressScreen.path),
                    text: 'Add Billing Address');
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
                          Text(address['addressLine']),
                          Text(address['landmark']),
                          Text('${address['city']}, ${address['pin']}'),
                          Text('${address['state']}, ${address['country']}'),
                        ]),
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
                            Navigator.pushNamed(context, AddressScreen.path),
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
