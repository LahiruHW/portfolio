// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jiraffe_flutter/entities/task.dart';
import 'package:jiraffe_flutter/entities/user.dart';

class JiraffeStateProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String taskCollectionID = 'tasks';
  final String memberCollectionID = 'users';

  // String projectId = "jiraffe-1";   // firebase project ID

  /// List of all the tasks in the product backlog
  List<Task> productBacklog = [];

  /// List of all the members in the team
  Map<String, User> teamMembers = {};

  /// Initialize the app data
  Future<void> initializeAppData() async {
    print("========================== initializing app data");

    // get the team members data
    await firestore
        .collection(memberCollectionID)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              // teamMembers = querySnapshot.docs.map((doc) => User.fromJson(doc, doc.id)).toList()
              teamMembers = {
                for (var doc in querySnapshot.docs)
                  doc.id: User.fromJson(doc, doc.id)
              }
            });

    // get the product backlog data
    await firestore.collection(taskCollectionID).get().then(
          (QuerySnapshot querySnapshot) => {
            productBacklog = querySnapshot.docs
                .map((doc) => Task.fromJson(doc, doc.id))
                .toList()
          },
        );
  }

  void checkData() {
    print("checking data");
    for (var element in productBacklog) {
      print(element);
      print("------------------------");
    }

    print("=====================================================");

    for (var element in teamMembers.entries) {
      print(element);
      print("------------------------");
    }
  }

}
