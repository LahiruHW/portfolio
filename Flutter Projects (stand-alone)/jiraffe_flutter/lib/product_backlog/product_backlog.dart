// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/product_backlog/product_backlog_table.dart';
import 'package:jiraffe_flutter/jiraffe_global_themes.dart';

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
              child: const ProductBacklogTable(),
            ),
          )
        ],
      ),
    );
  }

}
