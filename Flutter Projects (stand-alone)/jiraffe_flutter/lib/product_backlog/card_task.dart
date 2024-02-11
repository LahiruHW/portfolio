import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/GLOBAL/user_icon.dart';
import 'package:jiraffe_flutter/entities/index.dart';
import 'package:jiraffe_flutter/product_backlog/urgency_chip.dart';

class ProductBacklogCard extends StatelessWidget {
  const ProductBacklogCard({
    super.key,
    required this.task,
    required this.user,
    this.onDelete,
  });

  final Task task;
  final User user;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserIcon(user: user),
                  UrgencyChip(chipType: task.urgency),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(task.name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
