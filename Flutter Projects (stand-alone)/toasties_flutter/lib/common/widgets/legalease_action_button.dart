// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LegalEaseActionButton extends StatelessWidget {
  LegalEaseActionButton({
    super.key,
    this.onPressed,
    this.title,
    this.titleColor,
  });

  VoidCallback? onPressed;
  final String? title;
  Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: const Size(300, 60),
        maximumSize: const Size(300, 60),
        fixedSize: const Size(300, 60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? "Login with LegalEase account",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}
