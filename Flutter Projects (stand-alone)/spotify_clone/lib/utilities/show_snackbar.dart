import 'package:flutter/material.dart';

ScaffoldFeatureController showSnackBar(BuildContext context, String message, {Color barColor=Colors.red}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: "Avenir Next",
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: barColor,
    ),
  );
}
