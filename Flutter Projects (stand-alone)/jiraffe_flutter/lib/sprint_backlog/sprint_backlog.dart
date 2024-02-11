import 'package:flutter/material.dart';

class SprintBacklogPage extends StatefulWidget {
  const SprintBacklogPage({
    super.key,
  });

  @override
  State<SprintBacklogPage> createState() => _SprintBacklogPageState();
}

class _SprintBacklogPageState extends State<SprintBacklogPage> {
  
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
        "SPRINT BACKLOG PAGE BODY HERE",
        style: textStyle,
      ),
    );
  }
}
