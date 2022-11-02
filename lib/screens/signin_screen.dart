// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travelapp/screens/home_screen.dart';
import 'package:travelapp/screens/signup_screen.dart';
import '../utils/constant.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_inputfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Sign In", style: kHeadertextStyles),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Lottie.asset(
                        'images/anim/57997-travelers-find-location.json'),
                  ),
                  CustomInputField(
                    lable: "Email",
                    controller: emailController,
                    isPass: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Email';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                  ),
                  CustomInputField(
                    lable: "Password",
                    controller: passwordController,
                    isPass: true,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter Password";
                      }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    title: "Sign In",
                    callBack: () async {
                      if (_formKey.currentState!.validate()) {
                        signIn();
                      }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Constants.navigateToScreen(context, SignUpScreen());
                    },
                    child: Text(
                      "Create account?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then(
            (value) => Constants.replaceToScreen(
              context,
              OTPScreen(),
            ),
          );
    } on FirebaseAuthException catch (e) {
      Utils.showErrorFlush(context, e.code, e.message.toString());
    }
  }
}
