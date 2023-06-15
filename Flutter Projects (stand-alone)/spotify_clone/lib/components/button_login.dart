import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginButton extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  Color? borderColor = Colors.transparent;
  double? borderThickness = 0.6;
  Color? textColor = Colors.white;
  final String text;
  final VoidCallback onPressed;
  Image? headerIcon;

  final double horizontalPadding = 35;
  final double verticalPadding = 5;

  LoginButton({
    required this.height,
    required this.onPressed,
    required this.backgroundColor,
    this.borderColor,
    this.borderThickness,
    required this.text,
    this.textColor,
    this.headerIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return headerIcon != null
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            height: height,
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: headerIcon!,
              label: Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 16,
                  fontFamily: "Avenir Next",
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                    side: BorderSide(
                      color: borderColor ?? Colors.transparent,
                      width: borderThickness ?? 0.6,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            height: height,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                    side: BorderSide(
                      color: borderColor ?? Colors.transparent,
                      width: borderThickness ?? 0.6,
                    ),
                  ),
                ),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 16,
                      fontFamily: "Avenir Next",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
