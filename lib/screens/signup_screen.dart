// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travelapp/screens/signin_screen.dart';
import 'package:travelapp/utils/constant.dart';
import 'package:travelapp/widgets/custom_button.dart';

import '../widgets/custom_inputfield.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                    // ignore: prefer_const_constructors
                    Text(
                      "Sign Up",
                      style: kHeadertextStyles,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 5,
                      child: Lottie.asset('images/anim/90770-traveller.json'),
                    ),
                    CustomInputField(
                      lable: "Username",
                      controller: usernameController,
                      isPass: false,
                      // ignore: body_might_complete_normally_nullable
                      validator: (a) {},
                    ),
                    CustomInputField(
                      lable: "Email",
                      controller: emailController,
                      isPass: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please a Enter';
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

                    CustomButton(
                      title: "Sign Up",
                      callBack: () async {
                        if (_formKey.currentState!.validate()) {
                          signUp();
                        }
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Constants.navigateToScreen(context, SignInScreen());
                      },
                      child: Text(
                        "Sign in instead",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then(
        (value) async {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then(
                (value) => Constants.replaceToScreen(
                  context,
                  OTPScreen(),
                ),
              );
        },
      );
    } on FirebaseAuthException catch (e) {
      Utils.showErrorFlush(context, e.code, e.message);
    }
  }
}
