// @dart=2.9

import 'package:flutter/material.dart';

import 'homepage.dart';

//TODO: Add a new Menu page with buttons to: 
//    1. Play (i.e. start) the game
//    2. Show credits 
//        (based on the original game created by Dong Nguyen) 
//    3. Visit my github page

void main() => runApp(  MyApp() );


class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        
        
        return MaterialApp(          
            debugShowCheckedModeBanner: false,
            home: HomePage(),
        );

        
    }
}
