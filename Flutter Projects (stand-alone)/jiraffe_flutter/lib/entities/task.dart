// ignore_for_file: unused_element, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiraffe_flutter/product_backlog/urgency_chip.dart';

class Task {
  late final String id;
  late final String name;
  late final String tag;
  late final int story_points;
  late final String assigned_to;
  late final UrgencyType urgency;

  Task({
    this.id = '',
    required this.name,
    required this.tag,
    required this.story_points,
    required this.assigned_to,
    required this.urgency,
  });


  // print the task

  @override
  String toString() {
    return 'Task: { id: $id, name: $name, tag: $tag, story_points: $story_points, assigned_to: $assigned_to, urgency: $urgency }';
  }


  factory Task.fromJson(QueryDocumentSnapshot json, String id) {
    Map<String, dynamic> data = json.data() as Map<String, dynamic>;
    return Task(
      id: id,
      name: data['name'],
      tag: data['tag'],
      story_points: data['story_points'],
      assigned_to: data['assigned_to'],
      urgency: UrgencyType.values[ data['urgency'] ],
    );
  }

  Map<String, dynamic> _toJson(Task task) => {
        'name': task.name,
        'tag': task.tag,
        'story_points': task.story_points,
        'assigned_to': task.assigned_to,
        'urgency': task.urgency,
      };
}
