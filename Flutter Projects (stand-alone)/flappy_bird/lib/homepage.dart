import 'dart:async';
import 'package:flappy_bird/gameOverDialog.dart';
import 'package:flappy_bird/reUsedWidgets.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/loopingBase.dart';
import 'package:flappy_bird/staticRandomNumbers.dart';
import 'package:flappy_bird/strokeText.dart';

final birdKey = GlobalKey<_HomePageState>();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

    static double bird_y_axis = 0;

    static late final AudioCache audiocache;
    static late final AudioPlayer audioplayer;

    /// Random Number generator used throughout the runtime lifecycle
    static final randGen = RandomNums();

    static double g_force = 1.25; //1.5; // 2.5; //4.9;
    static double time = 0;
    static double height = 0;
    static double velocity = 1.0;
    static double initialHeight = bird_y_axis;

    late Bird playerBird;
    static bool birdGoesUp = true;
    int score = 0;

    bool has_game_started = false;    

    static double barrier_one_X = 3;
    double barrier_two_X = barrier_one_X + 1.5;   ///////////////////// distance between barriers ( 0.75 <= d <= 1.5 )

    String game_theme = "night";  // change between "day" or "night"

    /// The distance between the barriers
    late double barrierGap = 115;

    /// Size object that stores screen dimensions
    late Size screenSize;

    /// Stores the height of the device screen
    late double screenHeight;

    /// Stores the width of the device screen
    late double screenWidth;

    // ignore: todo
    // TODO: generate random heights (screen height*0.3) <= h <= (screen height*0.6)
    // ignore: non_constant_identifier_names
    static late List<double> bottom_barrier_heights = [400, 250];

    // barrier queue
    // static late List<Barrier?> bQueue = [];

    bool showAbout = false;

    final OutlinedText getReadyText = ReUsedWidgets.getReadyText;
    late final LoopingBase baseLoop;
    final AboutDialog aboutDialog = ReUsedWidgets.aboutDialog;

    late final GameOverDialog gameOverMsg;


    @override
    void initState(){
        super.initState();
        audioplayer = AudioPlayer(
                mode: PlayerMode.LOW_LATENCY
        );
        audiocache = AudioCache( 
            prefix: 'assets/audio/',
            fixedPlayer: audioplayer
        );
        baseLoop = LoopingBase(); 
    }

    // void collision(){
    //     WidgetsBinding.instance.addPostFrameCallback((_) {
    //       final RenderBox bird = birdKey.currentContext!.findRenderObject() as RenderBox;
    //       print(bird.localToGlobal(Offset.zero).dx);
    //       print(bird.localToGlobal(Offset.zero).dy);
    //     });
    // }

    void jump(){
        birdGoesUp = !birdGoesUp;
        audiocache.play('wing.wav');
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
          answer = true;
      } 
      return answer;
    }

    void startGame(BuildContext context){
        screenSize = MediaQuery.of(context).size;
        screenHeight = screenSize.height;
        screenWidth = screenSize.width;
        bottom_barrier_heights[0] = randGen.getRandDouble(screenHeight*0.3, screenHeight*0.6);
        bottom_barrier_heights[1] = randGen.getRandDouble(screenHeight*0.3, screenHeight*0.6);
        has_game_started = true;
        baseLoop.start();
        Timer.periodic(
            Duration(milliseconds: 45), 
            (timer) {
                time += 0.04;
                height = (-g_force*time*time) + (velocity*time);
                birdGoesUp = !birdGoesUp;
                setState(() {
                    bird_y_axis = initialHeight - height;
          
                    if (barrier_one_X < -3) { barrier_one_X = 3; }
                    else{ barrier_one_X -= 0.05; }

                    if (barrier_two_X < -3) { barrier_two_X = 3; }
                    else{ barrier_two_X -=  0.05; }

                });

                if ( isBirdDead() ){
                    audiocache.play('die.wav');
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

    void resetGame(){
    }

    @override
    Widget build(BuildContext context) {   
        screenSize = MediaQuery.of(context).size;
        screenHeight = screenSize.height;
        screenWidth = screenSize.width;
        return GestureDetector( 
            onTap: () {
                if ( has_game_started  && !isBirdDead() ){ jump(); }
                else if ( !has_game_started && isBirdDead() ) { audiocache.play('swoosh.wav'); }
                else { startGame(context); }
            },

            child: Scaffold(                
                body: Container(
                    decoration: BoxDecoration(
                        image: ReUsedWidgets.background(game_theme)
                    ),

                    child: Column(      
                        children: [

                            Expanded(
                                flex: 3,
                                child: Stack(
                                    clipBehavior: Clip.hardEdge,

                                    children: [

                                        playerBird = Bird(
                                            key: birdKey,
                                            birdHeight: 25,
                                            birdWidth: 35,
                                            birdY: bird_y_axis,
                                            directionUp: birdGoesUp,
                                        ),                                       

                                        // OR MAYBE JUST TEST THE BARRIER PAIR HERE (using Column + Flex)! 

                                        Barrier(
                                            barrierX: barrier_one_X,
                                            isDownBarrier: true,
                                            barrierWidth: 100.0,
                                            barrierHeight: bottom_barrier_heights[0],
                                        ),
                                        Barrier(
                                            barrierX: barrier_one_X,
                                            isDownBarrier: false,
                                            barrierWidth: 100.0,
                                            barrierHeight: screenHeight - (bottom_barrier_heights[0] + barrierGap),
                                        ),

                                        Barrier(
                                            barrierX: barrier_two_X,
                                            isDownBarrier: true,
                                            barrierWidth: 100.0,
                                            barrierHeight: bottom_barrier_heights[1],
                                        ),
                                        Barrier(
                                            barrierX: barrier_two_X,
                                            isDownBarrier: false,
                                            barrierWidth: 100.0,
                                            barrierHeight: screenHeight - (bottom_barrier_heights[1] + barrierGap),
                                        ),

                                        Container(
                                            alignment: Alignment(0, -0.5),
                                            child: ReUsedWidgets.scoreText(score)
                                        ), 
                                        
                                        baseLoop,  

                                        Container(
                                            alignment: Alignment(0, -0.25),
                                            child: has_game_started ? null : ( !isBirdDead() ? getReadyText : 
                                                GameOverDialog(
                                                    button1Func: (){},
                                                    button2Func: () => setState(() => showAbout = !showAbout),
                                                )
                                            )
                                        ),

                                        showAbout ? aboutDialog : Text(""),

                  // hitboxes here!
                  //////////////////////////////////////////////////////////////////////////////////////////////////////
                  ///////////////////////////////////// FOR DEBUGGING PURPOSES ONLY ////////////////////////////////////
                  //////////////////////////////////////////////////////////////////////////////////////////////////////

                                        // Container(
                                        //     alignment: Alignment(0, bird_y_axis),
                                        //     child: Container(
                                        //         height: 45,
                                        //         width: 40,
                                        //         decoration: BoxDecoration(
                                        //             shape: BoxShape.circle,
                                        //             // color: Colors.indigoAccent.shade700,              //deepPurple.shade900
                                        //             border: Border.all( color: Colors.redAccent.shade400)
                                        //         ),
                                        //     ),    
                                        // ),

                                    ],

                                ),
                                

                            ),

                        ],

                    ),

                ),

            )
        );
    }
}


