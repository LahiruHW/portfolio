// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/GLOBAL/user_icon.dart';
import 'package:jiraffe_flutter/entities/task.dart';
import 'package:jiraffe_flutter/entities/user.dart';
import 'package:jiraffe_flutter/jiraffe_global_themes.dart';
import 'package:jiraffe_flutter/product_backlog/urgency_chip.dart';

class ProductBacklogTableRow extends StatelessWidget {
  ProductBacklogTableRow({
    super.key,
    required this.task,
    required this.user,
    this.onDelete,
  });

  late final Task task;
  late final User user;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontFamily: "Barlow-Regular",
      fontWeight: FontWeight.w600,
      fontSize: 17,
    );

    const rowHeight = 55.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      height: rowHeight,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(right: 0.5),
              child: Center(
                child: Text(task.name, style: textStyle),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0.5),
              child: Center(
                child: Text(task.tag, style: textStyle),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox.expand(
              child: Container(
                color: Colors.white,
                // padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 0.5),
                child: UrgencyChip(chipType: task.urgency),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0.5),
              child: Center(
                child: UserIcon(user: user),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0.5),
              child: Center(
                child: Text(task.story_points.toString(), style: textStyle),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Material(
              color: Colors.white,
              child: InkWell(
                // onTap: () => print("DELETED ROW 2"),
                onTap: onDelete ?? () {},
                child: Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(left: 0.5),
                  child: Center(
                    child: JiraffeThemes.deleteIconImg,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
