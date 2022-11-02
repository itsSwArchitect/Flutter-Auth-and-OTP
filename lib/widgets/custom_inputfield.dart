// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String lable;
  final TextEditingController controller;
  final bool isPass;
  final String? Function(String?) validator;

  const CustomInputField(
      {required this.lable,
      required this.controller,
      required this.isPass,
      required this.validator});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      padding: EdgeInsets.only(bottom: 5),
      child: TextFormField(
        validator: widget.validator,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          labelText: widget.lable,
          filled: true,
        ),
        obscureText: widget.isPass,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        controller: widget.controller,
      ),
    );
  }
}
