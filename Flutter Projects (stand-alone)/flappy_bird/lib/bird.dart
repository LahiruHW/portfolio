import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Container(
            child: Image.asset('lib/assets/flappybird.png'),
            height: 60,
            width: 60
        );    
    }
}

