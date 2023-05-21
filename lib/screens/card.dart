import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/app_bar.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CardScreen extends StatefulWidget {
  static const String path = 'card';
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool isUpdate = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
      isUpdate = true;
      final Map<String, dynamic> creditCardModel =
          card.data() as Map<String, dynamic>;
      setState(() {
        cardNumber = creditCardModel['cardNumber'];
        expiryDate = creditCardModel['expiryDate'];
        cardHolderName = creditCardModel['cardHolderName'];
        cvvCode = creditCardModel['cvvCode'];
        isCvvFocused = creditCardModel['isCvvFocused'];
      });
    }
  }

  _updateCard() {
    if (isUpdate) {
      FirebaseFirestore.instance
          .collection('cards')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'cardHolderName': cardHolderName,
        'cvvCode': cvvCode,
        'isCvvFocused': isCvvFocused,
      });
    } else {
      FirebaseFirestore.instance
          .collection('cards')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'cardHolderName': cardHolderName,
        'cvvCode': cvvCode,
        'isCvvFocused': isCvvFocused,
      });
    }
    Navigator.pop(context);
  }

  void _onAddCard() {
    if (formKey.currentState!.validate()) {
      _updateCard();
    } else {
      print('invalid!');
    }
  }

  void _onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CapstoneAppBar(title: 'Card Payment', showCart: false),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Capstone',
                  frontCardBorder: Border.all(color: Colors.grey),
                  backCardBorder: Border.all(color: Colors.grey),
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  isSwipeGestureEnabled: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: brandColor,
                          cardNumberDecoration: const InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: TextStyle(color: brandColor),
                            labelStyle: TextStyle(color: brandColor),
                          ),
                          expiryDateDecoration: const InputDecoration(
                            hintStyle: TextStyle(color: brandColor),
                            labelStyle: TextStyle(color: brandColor),
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: const InputDecoration(
                            hintStyle: TextStyle(color: brandColor),
                            labelStyle: TextStyle(color: brandColor),
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: const InputDecoration(
                            hintStyle: TextStyle(color: brandColor),
                            labelStyle: TextStyle(color: brandColor),
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: _onCreditCardModelChange,
                        ),
                      ],
                    ),
                  ),
                ),
                CapstoneDarkElevatedButton(
                    onPressed: _onAddCard, text: 'Add Card'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
