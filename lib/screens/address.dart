import 'package:capstone/theme.dart';
import 'package:capstone/widgets/common/app_bar.dart';
import 'package:capstone/widgets/common/elevated_button_dark.dart';
import 'package:capstone/widgets/common/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  static const String path = 'address';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  bool isUpdate = false;

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
      isUpdate = true;
      final Map<String, dynamic> addressModel =
          card.data() as Map<String, dynamic>;
      setState(() {
        _addressLineController.text = addressModel['addressLine'];
        _landmarkController.text = addressModel['landmark'];
        _cityController.text = addressModel['city'];
        _stateController.text = addressModel['state'];
        _pinController.text = addressModel['pin'];
        _countryController.text = addressModel['country'];
      });
    }
  }

  _updateCard() {
    if (isUpdate) {
      FirebaseFirestore.instance
          .collection('address')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'addressLine': _addressLineController.text,
        'city': _cityController.text,
        'country': _countryController.text,
        'landmark': _landmarkController.text,
        'pin': _pinController.text,
        'state': _stateController.text
      });
    } else {
      FirebaseFirestore.instance
          .collection('address')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'addressLine': _addressLineController.text,
        'city': _cityController.text,
        'country': _countryController.text,
        'landmark': _landmarkController.text,
        'pin': _pinController.text,
        'state': _stateController.text
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CapstoneAppBar(title: 'Address', showCart: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Billing Address',
                    style: TextStyle(
                        color: brandColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  CapstoneTextFormField(
                    controller: _addressLineController,
                    hintText: "Address Line 1",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CapstoneTextFormField(
                    controller: _landmarkController,
                    hintText: "Landmark",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a Landmark';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CapstoneTextFormField(
                    controller: _cityController,
                    hintText: "City",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a City';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CapstoneTextFormField(
                    controller: _stateController,
                    hintText: "State",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a State';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CapstoneTextFormField(
                    controller: _countryController,
                    hintText: "Country",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a Country';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CapstoneTextFormField(
                    controller: _pinController,
                    hintText: "Postal Code",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a Postal Code';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CapstoneDarkElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _updateCard();
            }
          },
          text: isUpdate ? 'Update Address' : 'Add Address',
        ),
      ),
    );
  }
}
