import 'package:capstone/screens/address.dart';
import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BillingAddress extends StatefulWidget {
  const BillingAddress({super.key});

  @override
  State<BillingAddress> createState() => _BillingAddressState();
}

class _BillingAddressState extends State<BillingAddress> {
  bool isAdded = false;
  late final Map<String, dynamic> address;

  @override
  void initState() {
    super.initState();
    _getAddressInfo();
  }

  _getAddressInfo() async {
    DocumentSnapshot card = await FirebaseFirestore.instance
        .collection('address')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (card.exists) {
      isAdded = true;
      final Map<String, dynamic> addressModel =
          card.data() as Map<String, dynamic>;
      setState(() {
        address = addressModel;
      });
    }
  }

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
        isAdded
            ? SizedBox(
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
              )
            : CapstoneDarkElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AddressScreen.path),
                text: 'Add Billing Address')
      ],
    );
  }
}
