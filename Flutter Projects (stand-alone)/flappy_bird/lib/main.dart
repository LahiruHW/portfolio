// @dart=2.9

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

import 'homepage.dart';

import 'package:universal_io/io.dart' show Platform;

//TODO: Add a new Menu page with buttons to: 
//    1. Play (i.e. start) the game
//    2. Show credits 
//        (based on the original game created by Dong Nguyen) 
//    3. Visit my github page

// void main() => runApp( MyApp() );

void main() {

    print('OS: ${Platform.operatingSystem}');

    runApp( MyAppMobile() );

    if (Platform.operatingSystem == 'android' || Platform.operatingSystem == 'iOS' ) {
        runApp(  MyAppMobile() );
    }
    else {
        runApp( MyAppWeb() );
    }
}


class MyAppMobile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {     
            return MaterialApp(          
                debugShowCheckedModeBanner: false,
                home: HomePage(),
          );         
    }
}

class MyAppWeb extends StatelessWidget {
    @override
    Widget build(BuildContext context) {              
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

