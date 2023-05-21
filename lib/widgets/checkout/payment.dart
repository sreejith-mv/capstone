import 'package:capstone/screens/card.dart';
import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCardExist = false;

  @override
  void initState() {
    super.initState();
    _getCardInfo();
  }

  _getCardInfo() async {
    DocumentSnapshot card = await FirebaseFirestore.instance
        .collection('cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (card.exists) {
      isCardExist = true;
      final Map<String, dynamic> creditCardModel =
          card.data() as Map<String, dynamic>;
      setState(() {
        cardNumber = creditCardModel['cardNumber'];
        expiryDate = creditCardModel['expiryDate'];
        cardHolderName = creditCardModel['cardHolderName'];
        cvvCode = creditCardModel['cvvCode'];
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
            'Payment Method',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        isCardExist
            ? SizedBox(
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
                              TextSpan(text: cardHolderName),
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
                                      '${cardNumber.split(' ')[0]} XXXX XXXX ${cardNumber.split(' ')[3]}'),
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
                              TextSpan(text: expiryDate),
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
              )
            : CapstoneDarkElevatedButton(
                onPressed: () => Navigator.pushNamed(context, CardScreen.path),
                text: 'Add Payment Method')
      ],
    );
  }
}
