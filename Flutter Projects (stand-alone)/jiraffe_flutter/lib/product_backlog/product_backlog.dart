// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/product_backlog/urgency_chip.dart';
import '../jiraffe_global_themes.dart';

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
                const Text(
                  "switch here",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Barlow-Regular",
                  ),
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
              child: SingleChildScrollView(
                
                child: Column(
                  children: [
                    buildHeaderRow(),
              
                    // Normal Row
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.URGENT,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
              
                    // Normal Row
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.MEDIUM,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
              
                    // Normal Row
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.LOW,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
              
                    // Normal Row
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.IMPORTANT,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.IMPORTANT,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.URGENT,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.IMPORTANT,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.MEDIUM,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.IMPORTANT,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.LOW,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
                    buildRow(
                      name: "Col 1",
                      tag: "Col 2",
                      urgencyType: UrgencyType.IMPORTANT,
                      assignedTo: "Col 4",
                      storyPoints: 5,
                    ),
              
              
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildHeaderRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(right: 0.5),
            child: Center(
              child: Text("Name", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Center(
              child: Text("Tag", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Center(
              child: Text("Urgent Status", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Center(
              child: Text("Assigned To", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Center(
              child: Text("Story Points", style: textStyle),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(left: 0.5),
            child: Center(
              child: Text("Delete?", style: textStyle),
            ),
          ),
        ),
      ],
    );
  }


  Widget buildRow({
    required name,
    required tag,
    required urgencyType,
    required assignedTo,
    required storyPoints,
  }) {
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
                child: Text(name, style: textStyle),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0.5),
              child: Center(
                child: Text(tag, style: textStyle),
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
                child: UrgencyChip(chipType: urgencyType),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0.5),
              child: Center(
                child:
                    Text(assignedTo, style: textStyle), ///////////// use ID's!!
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0.5),
              child: Center(
                child: Text(storyPoints.toString(), style: textStyle),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () => print("DELETED ROW 2"),
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
