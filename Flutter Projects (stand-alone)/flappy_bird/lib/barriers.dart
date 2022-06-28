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
                // border: Border(
                //     top: BorderSide(width: 2),
                //     left: BorderSide(width: 2),
                //     right: BorderSide(width: 2),
                // )
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 10,
                    color: Colors.green.shade800
                ),
            )
        );
    }
}



