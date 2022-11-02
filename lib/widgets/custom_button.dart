import 'package:flutter/material.dart';

import '../utils/constant.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final VoidCallback callBack;
  const CustomButton({
    Key? key,
    required this.title,
    required this.callBack,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 13,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: widget.callBack,
        child: Text(
          widget.title,
          style: kButtonTextStyles,
        ),
      ),
    );
  }
}
