import 'package:flutter/material.dart';

// ignore: todo
//TODO: ANIMATE THE ANGLE OF THE BIRD USING EITHER THE SAME ANIMATION, OR A NEW ANIMATION CONTROLLER.

class Bird extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Container(
            child: Image.asset('assets/images/flappybird.png'),
            height: 60,
            width: 60,
            // color: Colors.amber,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber
            ),
        );    
    }
}

