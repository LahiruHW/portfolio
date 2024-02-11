import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/GLOBAL/fade_in_out_widget.dart';
import 'package:jiraffe_flutter/entities/index.dart';
import 'package:jiraffe_flutter/jiraffe_global_themes.dart';
import 'package:jiraffe_flutter/product_backlog/card_task.dart';
import 'package:jiraffe_flutter/product_backlog/row_header.dart';
import 'package:jiraffe_flutter/product_backlog/row_task.dart';

class ProductBacklogDataView extends StatelessWidget {
  const ProductBacklogDataView({
    super.key,
    required this.taskList,
    required this.userMap,
    required this.uiToggle,
  });

  final List<Task> taskList;
  final Map<String, User> userMap;
  final bool uiToggle;

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "Barlow-Regular",
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
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
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: !uiToggle
                  ? [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const ProductBacklogHeaderRow(),
                            Column(
                              children: taskList
                                  .map(
                                    (task) => FadeInOutWidget(
                                      child: ProductBacklogTableRow(
                                        task: task,
                                        user: userMap[task.assigned_to]!,
                                        // onDelete: () => provider.checkData(),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ]
                  : [
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 3/2,
                          crossAxisCount: 3,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ProductBacklogCard(
                            task: taskList[index],
                            user: userMap[taskList[index].assigned_to]!,
                            // onDelete: () => provider.checkData(),
                          ),
                          childCount: taskList.length,
                        ),
                      ),

                    ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            elevation: 8,
            backgroundColor: JiraffeThemes.mainBackgroundColor,
            // onPressed: () => provider.checkData(),
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
