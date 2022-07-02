import 'package:flutter/material.dart';

// ignore: todo
//TODO: ANIMATE THE ANGLE OF THE BIRD USING EITHER THE SAME ANIMATION, OR A NEW ANIMATION CONTROLLER.

class Bird extends StatelessWidget {
    
    final birdY;
    final double birdWidth;   // normal double value for a width ---------------------- default = 60
    final double birdHeight;  // out of 2, 2 being the entire height of the screen ---- default = 60
    
    Bird({
        this.birdY, 
        required this.birdWidth, 
        required this.birdHeight
    });
    
    @override
    Widget build(BuildContext context) {
        return AnimatedContainer(
            alignment: Alignment(0, birdY),
            duration: Duration(),
            child: Image.asset(
                'assets/images/flappybird.png',                
                height: birdHeight, 
                width: birdWidth,
                fit: BoxFit.fill,
            ),
            // color: Colors.amber,
        ) ;   
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
