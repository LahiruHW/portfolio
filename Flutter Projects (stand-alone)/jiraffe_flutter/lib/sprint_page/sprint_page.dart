import 'package:flutter/material.dart';

class SprintPage extends StatefulWidget {
  const SprintPage({
    super.key,
  });

  @override
  State<SprintPage> createState() => SprintPageState();
}

class SprintPageState extends State<SprintPage> {
  
  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "Barlow-Regular",
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "SPRINT PAGE BODY HERE",
        style: textStyle,
      ),
    );
  }
}
