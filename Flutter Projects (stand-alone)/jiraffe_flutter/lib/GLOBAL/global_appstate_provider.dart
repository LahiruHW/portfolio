import 'package:flutter/material.dart';

class JiraffeStateProvider extends ChangeNotifier {
  
  bool isSideBarOpen = false;

  // IMPLEMENT THE STATE PROVIDER HERE!!

  // One class for Product
  //    - each product has ONLY ONE product backlog

  // One class for Sprint:
  //    - ONE product can have MANY sprints

  // One class for User:
  //    - the members of the team are GLOBAL

  // One memb

  void toggleSideBarCollapse(bool isCollapsed) {
    isSideBarOpen = isCollapsed;
    notifyListeners();
  }

}
