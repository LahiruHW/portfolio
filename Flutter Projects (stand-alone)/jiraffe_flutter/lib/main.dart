// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiraffe_flutter/firebase_options.dart';
import 'jiraffe_global_themes.dart';
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
      child: JiraffeApp(),
    ),
  );
}

class JiraffeApp extends StatelessWidget {
  JiraffeApp({
    super.key,
  });

  final _controller = SidebarXController(
    selectedIndex: 0,
    extended: false,
  );
  final _key = GlobalKey<ScaffoldState>();

  final double GLOBAL_PADDING = 10;

  final textStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Barlow-Regular",
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SidebarX Example for JIRAffe",
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
                    child:
                        // Center(
                        //   child: Text(
                        //     "PAGE BODY HERE",
                        //     style: textStyle,
                        //   ),
                        // ),
                        ProductBacklogPage(),
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
