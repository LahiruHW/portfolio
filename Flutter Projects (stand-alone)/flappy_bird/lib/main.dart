
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

import 'homepage.dart';

import 'package:universal_io/io.dart' show Platform;

// ignore: todo
// TODO: Add a title card pagefor the other types of 

// ignore: todo
// TODO: Add a new Menu page with buttons to: 
//    1. Play (i.e. start) the game
//    2. Show credits 
//        (based on the original game created by Dong Nguyen with new features added by Lahiru Weliwitiya)
//        (theme music composed by C/\PS[LOCK])
//        ()
//    3. Visit my github page

void main() {
    print('--------------------------------- CURRENT OPERATING SYSTEM: ${Platform.operatingSystem}');
    String os = Platform.operatingSystem;
    os == 'android' || os == 'iOS' ? runApp(  MyAppMobile() ) : runApp( MyAppWeb() );
}

class MyAppMobile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        print("------------------------------------- Running mobile build");     
        return MaterialApp(          
            debugShowCheckedModeBanner: false,
            home: HomePage(),
        );         
    }
}

class MyAppWeb extends StatelessWidget {
    @override
    Widget build(BuildContext context) {              
        print("------------------------------------- Running desktop/web build");
        return FlutterWebFrame(
            builder: (context) =>           
                MaterialApp(          
                    debugShowCheckedModeBanner: false,
                    home: HomePage(),
                ), 
            maximumSize: Size(475.0, 812.0),
            enabled: kIsWeb,
            backgroundColor: Colors.grey, 
            clipBehavior: Clip.hardEdge,       
        );
    }        
}

