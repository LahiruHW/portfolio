import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
    
    final barrierWidth;
    final barrierHeight;
    final barrierX;
    final bool isDownBarrier;

    /// Constructor that creates a Barrier Widget
    Barrier({ 
        this.barrierX,
        this.barrierWidth,
        this.barrierHeight, 
        required this.isDownBarrier
    });

    double getXPos() => this.barrierX;
    double getWidth() => this.barrierWidth;
    double getHeight() => this.barrierHeight;
    bool isLowerBarrier() => this.isDownBarrier;

    @override
    Widget build(BuildContext context) {
        return AnimatedContainer(
            
            curve: Curves.linear,

            alignment: Alignment(barrierX , (isDownBarrier ? 1.05 : -1.05) ),
            // alignment: Alignment( ((2 * barrierX) + barrierWidth) / (2 - barrierWidth) , (isDownBarrier ? 1 : -1)  ),
            // transform: Matrix4.rotationZ( (isDownBarrier ? 0 : 1)  *pi),
            
            duration: Duration(seconds: 0),

            child: Container(

                // width: MediaQuery.of(context).size.width * barrierWidth / 3
                width: MediaQuery.of(context).size.width / (barrierWidth / 20),  
                 
                // MediaQuery.of(context).size.height * 3 / 4 * (barrierHeight / 2),
                // height: (MediaQuery.of(context).size.height / 2) - (barrierHeight / 2) , 
                height: barrierHeight,

                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        width: 2.5,
                        color: Colors.black.withOpacity(1.0)//Colors.green.shade800
                    ),

                    gradient: LinearGradient(
                        begin: Alignment.centerLeft, // (isDownBarrier ? Alignment.topLeft : Alignment.centerLeft ),
                        tileMode: TileMode.clamp,
                        end: Alignment.centerRight,
                        // colors: [Colors.white.withOpacity(0.001), Colors.green.shade800]
                        colors: [Colors.green.shade400, Colors.green.shade800]
                    )
                ),

            )
        );
    }

}
















class AnimatedBarrier extends StatefulWidget{
  
    final barrierWidth;
    final barrierHeight;
    final barrierX;
    final bool isDownBarrier;

    AnimatedBarrier({ 
        this.barrierX,
        this.barrierWidth,
        this.barrierHeight, 
        required this.isDownBarrier
    });
  
    double getXPos() => this.barrierX;
    double getWidth() => this.barrierWidth;
    double getHeight() => this.barrierHeight;
    bool isLowerBarrier() => this.isDownBarrier;

    @override
    State<StatefulWidget> createState() => _AnimatedBarrierState(
      isDownBarrier: this.isDownBarrier,
      barrierHeight: this.barrierHeight,
      barrierWidth: this.barrierWidth,
      barrierX: this.barrierX
    );

}


class _AnimatedBarrierState extends State<AnimatedBarrier> {
    
    final barrierWidth;
    final barrierHeight;
    final barrierX;
    final bool isDownBarrier;

    _AnimatedBarrierState({ 
        this.barrierX,
        this.barrierWidth,
        this.barrierHeight, 
        required this.isDownBarrier
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            
            alignment: Alignment(barrierX , (isDownBarrier ? 1.05 : -1.05) ),
            // alignment: Alignment( ((2 * barrierX) + barrierWidth) / (2 - barrierWidth) , (isDownBarrier ? 1 : -1)  ),
            // transform: Matrix4.rotationZ( (isDownBarrier ? 0 : 1)  *pi),
            
            child: Container(

                // width: MediaQuery.of(context).size.width * barrierWidth / 3
                width: MediaQuery.of(context).size.width / (barrierWidth / 20),  
                 
                // MediaQuery.of(context).size.height * 3 / 4 * (barrierHeight / 2),
                // height: (MediaQuery.of(context).size.height / 2) - (barrierHeight / 2) , 
                height: barrierHeight,

                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 10,
                        color: Colors.green.shade800
                    ),
                )

            )
        );
    }

}





















// Image.asset(
//     'assets/images/pipe-green.png',
//     width: 400.0,
//     height: 400.0,
// )

// class TestBarrier extends StatelessWidget {
//     final size;
//     TestBarrier({ this.size });
//     @override
//     Widget build(BuildContext context) {
//         return Container(
//             width: 100,
//             height: size,
//             decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                     width: 10,
//                     color: Colors.green.shade800
//                 ),
//             )
//         );
//     }
// }
