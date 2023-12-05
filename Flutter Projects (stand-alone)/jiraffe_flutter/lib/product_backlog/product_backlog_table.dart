// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/GLOBAL/global_appstate_provider.dart';
import 'package:jiraffe_flutter/GLOBAL/user_icon.dart';
import 'package:jiraffe_flutter/jiraffe_global_themes.dart';
import 'package:jiraffe_flutter/product_backlog/row_header.dart';
import 'package:jiraffe_flutter/product_backlog/row_task.dart';
import 'package:jiraffe_flutter/product_backlog/urgency_chip.dart';
import 'package:provider/provider.dart';

class ProductBacklogTable extends StatefulWidget {
  const ProductBacklogTable({
    super.key,
  });

  @override
  State<ProductBacklogTable> createState() => _ProductBacklogTableState();
}

class _ProductBacklogTableState extends State<ProductBacklogTable> {
  late final JiraffeStateProvider provider;

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "Barlow-Regular",
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );

  @override
  void initState() {
    super.initState();
    provider = JiraffeStateProvider();
  }

  @override
  void dispose() {
    provider.dispose(); // destroy the provider
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            const ProductBacklogHeaderRow(),
            FutureBuilder(
              future: provider.initializeAppData(),
              builder: (context, snapshot) => Column(
                children: provider.productBacklog
                    .map(
                      (task) => ProductBacklogTableRow(
                        task: task,
                        user: provider.teamMembers[task.assigned_to]!,
                        onDelete: () => provider.checkData()
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
