import 'dart:math';

import 'package:flutter/material.dart';



class MyBarrier extends StatelessWidget {
    final size;
    MyBarrier({ this.size });

    @override
    Widget build(BuildContext context) {
        return Container(
            width: 100,
            height: size,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 10,
                    color: Colors.green.shade800
                ),
            )
        );
    }




}




class Barrier2 extends StatelessWidget {
    
    final barrierWidth;
    final barrierHeight;
    final barrierX;
    final bool isDownBarrier;

    Barrier2({ 
        this.barrierX,
        this.barrierWidth,
        this.barrierHeight, 
        required this.isDownBarrier
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            
            alignment: Alignment(barrierX , (isDownBarrier ? 1.1 : -1.1) ),
            
            // alignment: Alignment( ((2 * barrierX) + barrierWidth) / (2 - barrierWidth) , (isDownBarrier ? 1 : -1)  ),
            
            // transform: Matrix4.rotationZ( (isDownBarrier ? 0 : 1)  *pi),
            
            child: Container(

                // MediaQuery.of(context).size.width * barrierWidth / 3
                width: MediaQuery.of(context).size.width / (barrierWidth / 20),  
                 
                // MediaQuery.of(context).size.height * 3 / 4 * (barrierHeight / 2),
                height: (MediaQuery.of(context).size.height / 2) - (barrierHeight / 2) , 

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