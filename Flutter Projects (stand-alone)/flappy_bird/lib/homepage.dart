import 'dart:async';

import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
    static double bird_y_axis = 0;

    double time = 0;

    double height = 0;

    double initialHeight = bird_y_axis;

    bool has_game_started = false;    

    void jump(){

        setState(() {
            time = 0;
            initialHeight = bird_y_axis;
        });

    }


    void startGame(){
        has_game_started = true;
        Timer.periodic(
            Duration(milliseconds: 60), 
            (timer) {
                time += 0.05;
                height = (-4.9*time*time) + (2.8*time);
                setState(() {
                    bird_y_axis = initialHeight - height;
                });
                if (bird_y_axis > 1){
                    timer.cancel();
                    has_game_started = false;
                }
            }
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Column(      
                children: [

                    Expanded(
                        flex: 3,
                        child: Stack(


                            children: [

                                GestureDetector(
                                    child: AnimatedContainer(
                                        alignment: Alignment(0 , bird_y_axis),
                                        color: Colors.blue,
                                        duration: Duration(
                                            milliseconds: 0
                                        ),
                                        child: Bird()
                                    ),
                                    onTap: () {
                                        if (has_game_started){ jump(); }
                                        else { startGame(); }
                                    },
                                ),


                                Container(
                                    alignment: Alignment(0, -0.25),
                                    child: has_game_started ? Text("") : Text("T A P   T O   P L A Y")
                                ),

                            ],


                        ),
                        

                        




                    ),

                    Container(
                        height: 15,
                        color: Colors.green
                    ),

                    Expanded(
                        child: Container(
                            color: Colors.brown,

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                              Text(
                                                  "SCORE",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20
                                                  ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                  "0",

                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 35
                                                  ),

                                              )
                                          ],
                                      ),

                                      

                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                              Text(
                                                  "BEST",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20
                                                  ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                  "10",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 35
                                                  ),
                                              )
                                          ],
                                      )



                                ],

                            ),

                        ),
                    ),

                ],



            ),

        );
    }
}



