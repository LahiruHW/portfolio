// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/sprint_page/sprint_page.dart';
import 'jiraffe_global_themes.dart';

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jiraffe_flutter/firebase_options.dart';
import 'package:jiraffe_flutter/sprint_backlog/sprint_backlog.dart';
import 'package:jiraffe_flutter/GLOBAL/global_appstate_provider.dart';
import 'package:jiraffe_flutter/product_backlog/product_backlog.dart';

import 'package:provider/provider.dart';
import 'GLOBAL/sidebarx/src/controller/controller.dart';
import 'GLOBAL/jiraffe_sidebarx.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(
    ChangeNotifierProvider(
      create: (context) => JiraffeStateProvider(),
      child: const JiraffeApp(),
    ),
  );
}

class JiraffeApp extends StatefulWidget {
  const JiraffeApp({
    super.key,
  });

  @override
  JiraffeAppState createState() => JiraffeAppState();

}


class JiraffeAppState extends State<JiraffeApp> {

  late final SidebarXController _controller; 
  
  final _key = GlobalKey<ScaffoldState>();
  
  final double GLOBAL_PADDING = 10;

  final textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "Barlow-Regular",
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );

  final pages = [
    const ProductBacklogPage(),
    const SprintPage(),
    const SprintBacklogPage(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();

    _controller = SidebarXController(
      selectedIndex: 0,
      extended: false,
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JIRAffe (Flutter Edition)",
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          // final isSmallScreen = MediaQuery.of(context).size.width < 600;

          return Scaffold(
            backgroundColor: Colors.grey.shade600,
            key: _key,
            appBar: null,
            drawer: JiraffeSidebarX(
              controller: _controller,
              padding: GLOBAL_PADDING,
            ),
            body: Row(
              children: [
                JiraffeSidebarX(
                  controller: _controller,
                  padding: GLOBAL_PADDING,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: GLOBAL_PADDING,
                      bottom: GLOBAL_PADDING,
                      // left: GLOBAL_PADDING / 4,
                      right: GLOBAL_PADDING,
                    ),
                    decoration: BoxDecoration(
                      color: JiraffeThemes.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: pages[_controller.selectedIndex],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
