import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
    final barrierWidth;
    final barrierHeight;
    final barrierX;
    final bool isDownBarrier;

    /// Constructor that creates a Barrier Widget
    const Barrier({
        Key? key,
        this.barrierX,
        this.barrierWidth,
        this.barrierHeight, 
        required this.isDownBarrier
    }): super(key: key);

    height() => this.barrierHeight;
    width() => this.barrierWidth;

    getLeftX() => (barrierX + barrierWidth)/(15 - barrierWidth);
    getRightX() => (2*barrierX + barrierWidth)/(barrierWidth - 15);

    bool hitsBird() {
      return false;
    }

    @override
    Widget build(BuildContext context) {

        // print(barrierX);
        // print("RIGHT EDGE = " + this.getRightX().toString() + "\n");

        return AnimatedContainer(
            curve: Curves.linear,
            alignment: Alignment(barrierX , (isDownBarrier ? 1.05 : -1.05) ),
            // alignment: Alignment( ((2 * barrierX) + barrierWidth) / (2 - barrierWidth) , (isDownBarrier ? 1 : -1)  ),
            
            duration: Duration(microseconds: 100),
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


                //////////////////////////////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////// FOR DEBUGGING PURPOSES ONLY ////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////////////////////


                // LEFT EDGE
                // child: Container(
                //     alignment: Alignment( getLeftX() , (isDownBarrier ? 1 : -1) ),
                //     child: VerticalDivider(
                //       color: Colors.blue,
                //       thickness: 5,
                //     )       
                // ),

                // RIGHT EDGE
                // child: Container(
                //     alignment: Alignment( getRightX() , (isDownBarrier ? 1 : -1) ),
                //     child: VerticalDivider(
                //       color: Colors.blue,
                //       thickness: 5,
                //     )       
                // ),

                // child: Container(
                //     alignment: Alignment( 0 , (isDownBarrier ? -1.04 : 1.04) ),
                //     child: Divider(
                //       color: Colors.red,
                //       thickness: 5,
                //     )       
                // ),

            )
        );
    }

}

// LEFT (vertical) EDGE:  (barrierX + barrierWidth)/(15-barrierWidth) , (isDownBarrier ? 1 : -1)
// RIGHT (vertical) EDGE: (2*barrierX + barrierWidth)/(barrierWidth-15) , (isDownBarrier ? 1 : -1)
// TOP (horizontal) EDGE: (check x-axis alignments)
// BOTTOM (horizontal) EDGE: (check x-axis alignments)

