import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameOverDialog extends StatelessWidget {

    GameOverDialog({
        this.button1Func,
        this.button2Func,
    });

    Function()? button1Func;
    Function()? button2Func;


  @override
  Widget build(BuildContext context) {

      return AlertDialog(
          
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.red.shade200,

          title: Text(
              "G A M E  O V E R",
              style: TextStyle(
                  fontFamily: "Flappy-Bird",
                  fontSize: 50,
                  fontWeight: FontWeight.w500
              ),
          ),

          alignment: Alignment(0 , 0),
          content: Text("That's it (for now)!"),
          elevation: 50,
          actions: [
              ElevatedButton.icon(
                  onPressed: button1Func,
                  icon: Icon(Icons.refresh),
                  label: Text("Play Again"),
              ),
              ElevatedButton.icon(
                  onPressed: button2Func,
                  icon: Icon(Icons.all_inclusive_sharp), 
                  label: Text("Show About..."),
              ),
          ],

      );

  }
}




