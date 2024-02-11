
import 'package:flutter/material.dart';
import 'barriers.dart';

// ignore: todo
//TODO: ANIMATE THE ANGLE OF THE BIRD USING EITHER THE SAME ANIMATION, OR A NEW ANIMATION CONTROLLER.

// ignore: must_be_immutable
class Bird extends StatelessWidget {
    final Key key;
    double birdY;
    final double birdWidth;   // normal double value for a width ---------------------- default = 60
    final double birdHeight;  // out of 2, 2 being the entire height of the screen ---- default = 60
    final bool directionUp;

    Bird({
        required this.key,
        required this.birdY, 
        required this.birdWidth, 
        required this.birdHeight,
        required this.directionUp
    });
    
    // Key getKey() => this.key;    
    void setY(double y) { this.birdY = y; }

    // Implement the collision detection between BIRD and a BARRIER objects
    bool collidesWith(Barrier barrierWidget){

        // this (BIRD) is the "circle"
        // it collides with a rectangle (i.e "Barrier" widgets)

        return false;
    }

    @override
    Widget build(BuildContext context) {  
        return AnimatedContainer(
            // key: key,
            alignment: Alignment(0, birdY),
            duration: Duration(),
            child: Transform.rotate(
                angle: birdY*0.5,
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



