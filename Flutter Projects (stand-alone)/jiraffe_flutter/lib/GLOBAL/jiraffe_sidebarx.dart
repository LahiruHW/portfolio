// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/jiraffe_global_themes.dart';
import 'sidebarx/sidebarx.dart';

class JiraffeSidebarX extends StatelessWidget {
  JiraffeSidebarX({
    super.key,
    required this.controller,
    this.padding = 10
  });

  final SidebarXController controller;

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "Barlow-Regular",
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );

  double padding;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.easeInOut,
      // headerDivider: Divider(),
      headerBuilder: (context, extended) => Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
        child: JiraffeThemes.jiraffeLogoSideBarImg,
      ),
      theme: SidebarXTheme(
        margin: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: JiraffeThemes.mainBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        hoverColor: JiraffeThemes.sideBarItemHoverColor,
        hoverTextStyle: textStyle,
        textStyle: textStyle,
        selectedTextStyle: textStyle,
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: JiraffeThemes.mainBackgroundColor,
          ),
        ),
        selectedItemDecoration: BoxDecoration(
          color: JiraffeThemes.sideBarItemSelectColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: JiraffeThemes.sideBarItemSelectColor,
          ),
        ),
        // iconTheme: IconThemeData(
        //   color: Colors.white.withOpacity(0.7),
        //   size: 20,
        // ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 250,
        margin: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: JiraffeThemes.mainBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: textStyle,
      ),
      items: [
        SidebarXItem(
          iconWidget: JiraffeThemes.jiraffeProductBacklogIcon,
          label: "Product Backlog",
          onTap: () => print("CLICKED 'Product Backlog'"),
        ),
        SidebarXItem(
          iconWidget: JiraffeThemes.jiraffeSprintsIcon,
          label: "Sprints",
          onTap: () => print("CLICKED 'Sprints'"),
        ),
        SidebarXItem(
          iconWidget: JiraffeThemes.jiraffeSprintBoardIcon,
          label: "Sprint Board",
          onTap: () => print("CLICKED 'Sprint Board'"),
        ),
        SidebarXItem(
          iconWidget: JiraffeThemes.jiraffeAdminViewIcon,
          label: "Admin View",
          onTap: () => print("CLICKED 'Admin View'"),
        ),
        SidebarXItem(
          iconWidget: const Icon(Icons.verified_user),
          label: "You",
          onTap: () => print("CLICKED ON MY ACCOUNT DETAILS"),
        )
      ],
    );
  }
}
