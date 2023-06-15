import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

Future showAnimDialog(BuildContext context) {
  return showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    curve: Curves.easeInExpo,
    duration: const Duration(milliseconds: 800),
    animationType: DialogTransitionType.slideFromBottom,
    barrierColor: Colors.transparent,
    alignment: Alignment.bottomCenter,
    builder: (BuildContext context) {
      return const Dialog(
        alignment: Alignment.bottomCenter,
        shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        backgroundColor: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Please enter a valid email address",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: "Avenir Next",
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    },
  );
}
