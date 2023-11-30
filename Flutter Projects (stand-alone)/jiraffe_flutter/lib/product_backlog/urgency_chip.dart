import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/jiraffe_global_themes.dart';

enum UrgencyType { URGENT, IMPORTANT, MEDIUM, LOW }

class UrgencyChip extends StatelessWidget {
  const UrgencyChip({
    super.key,
    required this.chipType,
  });

  final UrgencyType chipType;
  final horizontalPadding = 10.0;

  final textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: "Barlow-Regular",
  );

  @override
  Widget build(BuildContext context) {
    switch (chipType) {
      case UrgencyType.MEDIUM:
        return Chip(
          label: const Text("Medium"),
          backgroundColor: JiraffeThemes.medium,
          labelStyle: textStyle,
          labelPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        );

      case UrgencyType.IMPORTANT:
        return Chip(
          label: const Text("Important"),
          backgroundColor: JiraffeThemes.important,
          labelStyle: textStyle,
          labelPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        );

      case UrgencyType.URGENT:
        return Chip(
          label: const Text("Urgent"),
          backgroundColor: JiraffeThemes.urgent,
          labelStyle: textStyle,
          labelPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        );

      default:
        return Chip(
          label: const Text("Low"),
          backgroundColor: JiraffeThemes.low,
          labelStyle: textStyle,
          labelPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        );
    }
  }
}
