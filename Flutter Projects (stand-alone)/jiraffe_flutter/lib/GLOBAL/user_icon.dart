import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/entities/user.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({
    super.key,
    required this.user,
  });

  final User user;

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "Barlow-Regular",
    // fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    final text = user.firstName[0] + user.lastName[0];
    final colour = Color(int.parse('0xff${user.colourHex}'));
    return Tooltip(
      message: "${user.firstName} ${user.lastName}",
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black, width: 0.2),
      ),
      textStyle: textStyle,
      child: CircleAvatar(
        backgroundColor: colour,
        child: Text(
          text,
          style: colour.computeLuminance() > 0.5
              ? textStyle.copyWith(color: Colors.black, fontSize: 17)
              : textStyle.copyWith(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
