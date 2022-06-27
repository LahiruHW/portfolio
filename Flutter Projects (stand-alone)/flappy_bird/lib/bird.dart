import 'package:flutter/material.dart';

// ignore: todo
//TODO: ANIMATE THE ANGLE OF THE BIRD USING EITHER THE SAME ANIMATION, OR A NEW ANIMATION CONTROLLER.

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

