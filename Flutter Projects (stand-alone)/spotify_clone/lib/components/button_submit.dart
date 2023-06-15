// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  Color backGroundColor;
  Color overlayColor;
  Color titleColor;

  SubmitButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.titleColor = Colors.white,
    this.backGroundColor = const Color.fromRGBO(83, 83, 83, 1.0),
    this.overlayColor = const Color.fromRGBO(255, 255, 255, 0.125),
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          // const Color.fromRGBO(83, 83, 83, 1.0),
          backGroundColor,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          // const Color.fromRGBO(255, 255, 255, 0.125),
          overlayColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
            side: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 20,
          right: 20,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 16,
            fontFamily: "Avenir Next",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
