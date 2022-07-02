import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/loopingBase.dart';
import 'package:flappy_bird/staticRandomNumbers.dart';
import 'package:flappy_bird/strokeText.dart';
import 'package:flutter/material.dart';

// import 'package:simple_animations/simple_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    static double bird_y_axis = 0;

    late final AudioCache cache;
    late final AudioPlayer player;


    double g_force = 1.5; // 2.5; //4.9;

    double time = 0;

    double height = 0;

    double velocity = 1.0;

    double initialHeight = bird_y_axis;

    bool has_game_started = false;    

    static double barrier_one_X = 3;

    double barrier_two_X = barrier_one_X + 1.5;   ///////////////////// distance between barriers ( 0.75 <= d <= 1.5 )

    String game_theme = "day";      // "day" or "night"

    /// The distance between the barriers
    late double barrierGap = 100;

    late Size screenSize;

    // TODO: generate random heights (screen height*0.3) <= h <= (screen height*0.6)
    late List<double> bottom_barrier_heights = [400, 250];
    
         

    int score = 10;

    final OutlinedText get_ready_text = OutlinedText(
        "Get Ready!", 
        font: 'Flappy-Bird', 
        fontSize: 90,
        textColor: Colors.greenAccent.shade700, 
        strokeColor: Colors.white, 
        strokeWidth: 6
    );

    final OutlinedText game_over_text = OutlinedText(
        "GamE OvEr", 
        font: 'Flappy-Bird', 
        fontSize: 90,
        textColor: Colors.orange.shade400, 
        strokeColor: Colors.white, 
        strokeWidth: 6
    );


    late final LoopingBase baseLoop;


    @override
    void initState(){
        super.initState(); 
        player = AudioPlayer(
                mode: PlayerMode.LOW_LATENCY
        );
        cache = AudioCache( 
            prefix: 'assets/audio/',
            fixedPlayer: player
        );
        baseLoop = LoopingBase();
    }

    void jump(){
        cache.play('wing.wav');
        setState(() {
            time = 0;
            initialHeight = bird_y_axis;
        });
    }

    bool isBirdDead(){
      bool answer = false;
      //if (bird_y_axis > 1 || bird_y_axis < -1){
      // if (bird_y_axis > 1.15){
      if (bird_y_axis > 0.7){
          cache.play('die.wav');
          answer = true;
      } 
      return answer;
    }

    void startGame(){
        // bottom_barrier_heights.add(RandomNums.getRandDouble(screenSize.height*0.3, screenSize.height*0.6));
        // bottom_barrier_heights.add(RandomNums.getRandDouble(screenSize.height*0.3, screenSize.height*0.6));
        has_game_started = true;
        baseLoop.start();
        Timer.periodic(
            Duration(milliseconds: 60), 
            (timer) {
                time += 0.04;
                height = (-g_force*time*time) + (velocity*time);
                setState(() {
                    bird_y_axis = initialHeight - height;

                    if (barrier_one_X < -3) { barrier_one_X = 3; }
                    else{ barrier_one_X -= 0.05; }

                    if (barrier_two_X < -3) { barrier_two_X = 3; }
                    else{ barrier_two_X -= 0.05; }

                });

                if ( isBirdDead() ){
                    baseLoop.stop();
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
        screenSize = MediaQuery.of(context).size;
        return GestureDetector( 
            onTap: () {
                if ( has_game_started ){ jump(); }
                else { startGame(); }
                // print( "---------------------------------------screen height: ${screenSize.height}" );
                // print( "---------------------------------------bottom height: ${bottom_barrier_heights[0]}" );
                // print( "---------------------------------------top height: ${screenSize.height - (bottom_barrier_heights[0] + barrierGap)}" );
            },
            child: Scaffold(
                
                body: Container(
                    
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: 
                                (game_theme == "day") ? 
                                  (ColorFilter.mode(Colors.blue.withOpacity(0.4), BlendMode.saturation)) 
                                  : (null),
                            image: AssetImage('assets/images/background-${game_theme}.png'),
                            fit: BoxFit.fill
                        )
                    ),

                    child: Column(      
                        children: [

                            Expanded(
                                flex: 3,
                                child: Stack(
                                    clipBehavior: Clip.hardEdge,

                                    children: [

                                        Bird(
                                            birdHeight: 60,
                                            birdWidth: 60,
                                            birdY: bird_y_axis
                                        ),

                                        Container(
                                            alignment: Alignment(0, -0.25),
                                            child: has_game_started ? Text("") : get_ready_text
                                        ),


                                        // method to generate lower barriers

                                        // method to generate higher barriers


                                        // OR MAYBE JUST TEST THE BARRIER PAIR HERE (using Column + Flex)! 

                                        Barrier2(
                                            barrierX: barrier_one_X,
                                            isDownBarrier: true,
                                            barrierWidth: 100.0,
                                            // barrierHeight: bottom_barrier_heights[0],
                                            barrierHeight: screenSize.height*0.3
                                        ),
                                        Barrier2(
                                            barrierX: barrier_one_X,
                                            isDownBarrier: false,
                                            barrierWidth: 100.0,
                                            // barrierHeight: screenSize.height - (bottom_barrier_heights[0] + barrierGap),
                                            barrierHeight: screenSize.height - (screenSize.height*0.3 + barrierGap), 
                                        ),



                                        Barrier2(
                                            barrierX: barrier_two_X,
                                            isDownBarrier: true,
                                            barrierWidth: 100.0,
                                            // barrierHeight: bottom_barrier_heights[1],
                                            barrierHeight: screenSize.height*0.6
                                        ),
                                        Barrier2(
                                            barrierX: barrier_two_X,
                                            isDownBarrier: false,
                                            barrierWidth: 100.0,
                                            // barrierHeight: screenSize.height - (bottom_barrier_heights[1] + barrierGap),
                                            barrierHeight: screenSize.height - (screenSize.height*0.6 + barrierGap),
                                        ),


                                        Container(
                                            alignment: Alignment(0, -0.5),
                                            child: OutlinedScoreText(
                                              "${score}", 
                                              font: 'Flappy-Bird-Score', 
                                              fontSize: 70, 
                                              textColor: Colors.white, 
                                              strokeColor: Colors.black, 
                                              strokeWidth: 100
                                            )
                                        ), 

                                        //////////////////////////////////////////////////////////////////////////////////
                                        //////////////////////////////////////////////////////////////////////////////////
                                        //////////////////////////////////////////////////////////////////////////////////                                        
                                        //////////////////////////////////////////////////////////////////////////////////
                                        //////////////////////////////////////////////////////////////////////////////////
                                        
                                        baseLoop
                                        
                                    ],

                                ),
                                

                            ),

                            // Expanded(
                            //     child: Container(
                            //         color: Colors.brown,
                            //         child: Row(
                            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //             children: [
                            //                   Column(
                            //                       mainAxisAlignment: MainAxisAlignment.center,
                            //                       children: [
                            //                           Text(
                            //                               "SCORE",
                            //                               style: TextStyle(
                            //                                   color: Colors.white,
                            //                                   fontSize: 20
                            //                               ),
                            //                           ),
                            //                           SizedBox(height: 20),
                            //                           Text(
                            //                               "0",
                            //                               style: TextStyle(
                            //                                   fontFamily: 'Flappy-Bird',
                            //                                   color: Colors.white,
                            //                                   fontSize: 80
                            //                               ),
                            //                           )
                            //                       ],
                            //                   ),

                            //                   Column(
                            //                       mainAxisAlignment: MainAxisAlignment.center,
                            //                       children: [
                            //                           Text(
                            //                               "BEST",
                            //                               style: TextStyle(
                            //                                   color: Colors.white,
                            //                                   fontSize: 20
                            //                               ),
                            //                           ),
                            //                           SizedBox(height: 20),
                            //                           Text(
                            //                               "10",
                            //                               style: TextStyle(
                            //                                   fontFamily: 'Flappy-Bird',
                            //                                   color: Colors.white,
                            //                                   fontSize: 80
                            //                               ),
                            //                           )
                            //                       ],
                            //                   )
                            //             ],
                            //         ),
                            //     ),
                            // ),

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



// AnimatedContainer(
//     duration: Duration(milliseconds: 0),
//     alignment: Alignment(barrier_one_X , 1.1),
//     child: MyBarrier(size: 300.0,),
// ),

// AnimatedContainer(
//     duration: Duration(milliseconds: 0),
//     alignment: Alignment(barrier_one_X , -1.1),
//     child: MyBarrier(size: 300.0,),
// ),


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



// AnimatedContainer(
//     // transform: Matrix4.rotationZ(radians),
//     alignment: Alignment(0 , bird_y_axis),  /////////////// y-axis position of bird
//     // color: Colors.blue,
//     duration: Duration(),
//     child: Bird() 
// ),
