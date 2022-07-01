import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  /// Text to display
  final String text;

  /// Original text style (if you weren't outlining)
  ///
  /// Do not specify `color` inside this: use [textColor] instead.
  final TextStyle style;

  /// Text color
  final Color textColor;

  /// Outline stroke color
  final Color strokeColor;

  /// Outline stroke width
  final double strokeWidth;

  final String font;

  final double fontSize;

  /// Places a stroke around text to make it appear outlined
  /// Adapted from https://stackoverflow.com/a/55559435/11846040
  const OutlinedText(
    this.text, {
    Key? key,
    this.style = const TextStyle(),
    required this.font,
    required this.fontSize,
    required this.textColor,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0,0),
      children: [

        Text(                                     /////////////// grey/black outer lining of whitestroke
          text,
          style: style.copyWith(
            fontFamily: font,
            fontSize: fontSize+1,
            foreground: Paint()
              ..strokeWidth = strokeWidth + 5
              ..color = Colors.grey.shade800
              ..style = PaintingStyle.stroke,

          ),
        ),

        Text(                                     //////////////// stroke colour
          text,
          style: style.copyWith(
            fontFamily: font,
            fontSize: fontSize,
            letterSpacing: 0.1,
            foreground: Paint()
              ..strokeWidth = strokeWidth
              ..color = strokeColor
              ..style = PaintingStyle.stroke,
          ),
        ),

        Text(                                       ////////////// actual text
          text,
          style: style.copyWith(
              fontFamily: font,
              fontSize: fontSize,
              foreground: Paint()
                ..color = textColor,
              shadows: [
                  Shadow(
                      color: Colors.green.shade700,
                      offset: Offset(-1, 2))
              ]

          ),
        ),



      ],
    );
  }
}




class OutlinedScoreText extends StatelessWidget{
  

    /// Text to display
    final String text;

    /// Original text style (if you weren't outlining)
    ///
    /// Do not specify `color` inside this: use [textColor] instead.
    final TextStyle style;

    /// Text color
    final Color textColor;

    /// Outline stroke color
    final Color strokeColor;

    /// Outline stroke width
    final double strokeWidth;

    final String font;

    final double fontSize;

    /// Places a stroke around text to make it appear outlined
    /// Adapted from https://stackoverflow.com/a/55559435/11846040
    const OutlinedScoreText(
      this.text, {
      Key? key,
      this.style = const TextStyle(),
      required this.font,
      required this.fontSize,
      required this.textColor,
      required this.strokeColor,
      required this.strokeWidth,
    });


    @override
    Widget build(BuildContext context) {
    
        return Container(
            child: Text(
                text,
                style: style.copyWith(
                    fontFamily: font,
                    fontSize: fontSize,
                    foreground: Paint()
                      ..color = textColor
                      ..strokeWidth = strokeWidth,
                    shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(4, 4))
                    ]
                ),
            ),
        );
    }


}
