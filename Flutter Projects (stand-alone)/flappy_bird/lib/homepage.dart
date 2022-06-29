import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/strokeText.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    static double bird_y_axis = 0;

    double g_force = 2.5; //4.9;

    double time = 0;

    double height = 0;

    double velocity = 1.5;

    double initialHeight = bird_y_axis;

    bool has_game_started = false;    

    static double barrier_one_X = 3;

    double barrier_two_X = barrier_one_X + 0.75;   /////////////////////////////////////////////// distance between barriers

    @override
    void initState() {
        super.initState(); 
    }



    void jump(){

        final cache = AudioCache();
        cache.play('audio/wing.wav');

        setState(() {
            time = 0;
            initialHeight = bird_y_axis;
        });
    }

    bool isBirdDead(){
      bool answer = false;
      //if (bird_y_axis > 1 || bird_y_axis < -1){
      if (bird_y_axis > 1.5){
          answer = true;
      } 
      return answer;
    }

    void startGame(){
        has_game_started = true;
        Timer.periodic(
            Duration(milliseconds: 60), 
            (timer) {
                time += 0.05;
                height = (-g_force*time*time) + (velocity*time);
                setState(() {
                    bird_y_axis = initialHeight - height;


                if (barrier_one_X < -3) { barrier_one_X = 3; }
                else{ barrier_one_X -= 0.05; }

                if (barrier_two_X < -3) { barrier_two_X = 3; }
                else{ barrier_two_X -= 0.05; }

                });

                if ( isBirdDead() ){
                    timer.cancel();
                    has_game_started = false;
                    
                    // if (Platform.isAndroid) {          // move this to the exit method!
                    //     SystemNavigator.pop();
                    // } else if (Platform.isIOS) {
                    //     exit(0);
                    // }
                }
            }
        );
    }

    @override
    Widget build(BuildContext context) {
        
        return GestureDetector( 
            onTap: () {
                if ( has_game_started ){ jump(); }
                else { startGame(); }
            },
            child: Scaffold(
                
                body: 
                
                
                Container(
                    
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background-day.png'),
                            fit: BoxFit.fill
                        )
                    ),

                    child: Column(      
                        children: [

                            Expanded(
                                flex: 3,
                                child: Stack(


                                    children: [


                                        AnimatedContainer(
                                            alignment: Alignment(0 , bird_y_axis),
                                            // color: Colors.blue,
                                            duration: Duration(
                                                milliseconds: 0
                                            ),
                                            child: Bird()
                                        ),

                                        Container(
                                            alignment: Alignment(0, -0.25),
                                            child: has_game_started ? Text("") : 

                                            OutlinedText(
                                                "Get Ready!", 
                                                font: 'Flappy-Bird', 
                                                fontSize: 90,
                                                textColor: Colors.greenAccent.shade700, 
                                                strokeColor: Colors.white, 
                                                strokeWidth: 6
                                            )


                                        ),













                                        AnimatedContainer(
                                            duration: Duration(milliseconds: 0),
                                            alignment: Alignment(barrier_one_X , 1.1),
                                            child: MyBarrier(size: 300.0,),
                                        ),
                                        
                                        AnimatedContainer(
                                            duration: Duration(milliseconds: 0),
                                            alignment: Alignment(barrier_one_X , -1.1),
                                            child: MyBarrier(size: 300.0,),
                                        ),


                                        // AnimatedContainer(
                                        //     duration: Duration(milliseconds: 0),
                                        //     alignment: Alignment(barrier_two_X , 1.1),
                                        //     child: MyBarrier(size: 150.0,),
                                        // ),

                                        // AnimatedContainer(
                                        //     duration: Duration(milliseconds: 0),
                                        //     alignment: Alignment(barrier_two_X , -1.1),
                                        //     child: MyBarrier(size: 250.0,),
                                        // )

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
                                                              fontFamily: 'Flappy-Bird',
                                                              color: Colors.white,
                                                              fontSize: 80
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
                                                              fontFamily: 'Flappy-Bird',
                                                              color: Colors.white,
                                                              fontSize: 80
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

                ),

            )
        );
    }
}





// collision detection:

/*


  Check if top/bottom borders of BIRD is colliding with bottom/top sides of barriers

  Check if 

*/


