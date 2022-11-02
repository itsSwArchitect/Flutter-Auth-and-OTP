// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travelapp/screens/main_home_screen.dart';
import 'package:travelapp/utils/constant.dart';

final userCollectionReference = FirebaseFirestore.instance.collection('users');

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<OTPScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  String verificationID = "";
  final countryPicker = const FlCountryCodePicker();
  String countryCode = "+92";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verfication"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("images/anim/otpverification.json"),
              Row(
                children: [
                  InkWell(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          countryCode,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    onTap: () async {
                      final code =
                          await countryPicker.showPicker(context: context);

                      try {
                        setState(() {
                          countryCode = code!.dialCode.toString();
                        });
                      } catch (e) {
                        Utils.showErrorFlush(
                            context, e.hashCode.toString(), e.toString());
                      }
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                        ),
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              Visibility(
                // ignore: sort_child_properties_last
                child: TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                    hintText: 'OTP',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(''),
                    ),
                  ),
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                ),
                visible: otpVisibility,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  if (otpVisibility) {
                    verifyOTP();
                  } else {
                    loginWithPhone();
                  }
                },
                child: Text(
                  otpVisibility ? "Verify" : "Send OTP",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // getDocs() async {
  //   dynamic data;
  //   await userCollectionReference.get().then((value) {
  //     data = value.docs.map((e) {
  //       return e.data();
  //     }).toList();
  //   });

  //   print(data);
  // }

  // setSearch() async {
  //   dynamic data;
  //   var result = await userCollectionReference
  //       .where("name", isEqualTo: "ALi")
  //       .get()
  //       .then((value) {
  //     data = value.docs.map((e) {
  //       return e.data();
  //     }).toList();
  //   });

  //   print(data);
  // }

  // setDocs() async {
  //   final json = {"Name": "OkayG", "age": "dont Know"};
  //   await userCollectionReference.add(json);
  // }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: countryCode + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        Utils.showErrorFlush(context, e.code, e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).whenComplete(
      () {
        Utils.showErrorFlush(context, "Wowww", "You Done it");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainHomeScreen();
            },
          ),
        );
      },
    );
  }
}
