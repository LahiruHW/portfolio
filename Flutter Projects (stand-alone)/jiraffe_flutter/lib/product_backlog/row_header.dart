// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProductBacklogHeaderRow extends StatelessWidget {
  const ProductBacklogHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontFamily: "Barlow-Regular",
      fontWeight: FontWeight.w600,
      fontSize: 17,
    );

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(right: 0.5),
            child: Center(
              child: Text("Name", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Center(
              child: Text("Tag", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Center(
              child: Text("Urgent Status", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Center(
              child: Text("Assigned To", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Center(
              child: Text("Story Points", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(left: 0.5),
            child: Center(
              child: Text("Delete?", style: textStyle),
            ),
          ),
        ),
      ],
    );
  }
}
