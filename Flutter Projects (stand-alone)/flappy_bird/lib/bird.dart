import 'dart:math';
import 'package:flutter/material.dart';
import 'barriers.dart';

// ignore: todo
//TODO: ANIMATE THE ANGLE OF THE BIRD USING EITHER THE SAME ANIMATION, OR A NEW ANIMATION CONTROLLER.

class Bird extends StatelessWidget {
    
    final birdY;
    final double birdWidth;   // normal double value for a width ---------------------- default = 60
    final double birdHeight;  // out of 2, 2 being the entire height of the screen ---- default = 60
    final bool directionUp;

    Bird({
        this.birdY, 
        required this.birdWidth, 
        required this.birdHeight,
        required this.directionUp
    });
    
    // Implement the collision detection between BIRD and a BARRIER objects
    bool collidesWith(Barrier barrierWidget){

        // this (BIRD) is the "circle"
        // it collides with a rectangle (i.e "Barrier" widgets)

        return false;
    }

    @override
    Widget build(BuildContext context) {  
        print(directionUp);
        return AnimatedContainer(
            alignment: Alignment(0, birdY),
            duration: Duration(),
            child: Transform.rotate(
                angle: sin(birdY) * 0.5,
                child:
                Image.asset(
                    // 'assets/images/flappybird.png',
                    'assets/images/yellowbird-${
                        // ( birdY == 0 ? "mid" : (birdY > 0 ? "up" : "down") )
                        (directionUp ? "down" : "up")
                    }flap.png',
                    height: birdHeight, 
                    width: birdWidth,
                    fit: BoxFit.fill,
                ),
            ),
            // color: Colors.amber,
        );   
    }
}









// class Bird1 extends StatelessWidget {
//     @override
//     Widget build(BuildContext context) {
//         return Container(
//             child: Image.asset('assets/images/flappybird.png'),
//             height: 60,
//             width: 60,
//             // color: Colors.amber,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.amber
//             ),
//         );    
//     }
// }
