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


    // @override
    // Widget build(BuildContext context) {
    //     return Container(
    //         width: 100,
    //         height: size,
    //         child: Image.asset(//ADD pipe-gree.png here! )       
    //         decoration: BoxDecoration(
    //             color: Colors.green,
    //             borderRadius: BorderRadius.circular(10),
    //             border: Border.all(
    //                 width: 10,
    //                 color: Colors.green.shade800
    //             ),
    //         )
    //     );
    // }





}



