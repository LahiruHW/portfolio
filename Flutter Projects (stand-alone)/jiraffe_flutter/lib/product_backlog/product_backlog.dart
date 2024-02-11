// ignore_for_file: avoid_print

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
import 'package:jiraffe_flutter/GLOBAL/global_appstate_provider.dart';
import 'package:jiraffe_flutter/product_backlog/product_backlog_table.dart';
import 'package:jiraffe_flutter/jiraffe_global_themes.dart';
import 'package:provider/provider.dart';

// class ProductBacklogPage extends StatefulWidget {
class ProductBacklogPage extends StatelessWidget {
  const ProductBacklogPage({
    super.key,
  });

  static const routeName = "/product_backlog";

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "Barlow-Regular",
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );

  final rowHeight = 55.0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JiraffeStateProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
      child: Column(
        children: [
          // HEADER ROW HERE
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                JiraffeThemes.productBacklogHeaderImg,
                AnimatedToggleSwitch<bool?>.dual(
                  current: provider.productBacklogUIToggle,
                  first: false,
                  second: true,
                  height: 35,
                  borderWidth: 0,
                  style: const ToggleStyle(
                    backgroundColor: Colors.grey,
                    indicatorColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 250),
                  animationCurve: Curves.easeInOut,
                  onChanged: (val) => provider.toggleProductBacklogUI(),
                  textBuilder: (val) => val! ? JiraffeThemes.pbCardViewIcon : JiraffeThemes.pbListViewIcon, 
                )
              ],
            ),
          ),

          // TABLE HERE
          Expanded(
            // Product Backlog Table
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: JiraffeThemes.sideBarBackgroundColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder(
                future: provider.initializeAppData(),
                builder: (context, snapshot) => ProductBacklogDataView(
                  taskList: provider.productBacklog,
                  userMap: provider.teamMembers,
                  uiToggle: provider.productBacklogUIToggle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
