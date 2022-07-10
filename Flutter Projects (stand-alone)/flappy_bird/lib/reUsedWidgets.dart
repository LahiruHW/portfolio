import 'package:flappy_bird/strokeText.dart';
import 'package:flutter/material.dart';

class ReUsedWidgets{

    static DecorationImage background(theme) => DecorationImage(
        colorFilter: 
            (theme == "day") ? 
              (ColorFilter.mode(Colors.blue.withOpacity(0.4), BlendMode.saturation)) : (null),
        image: AssetImage('assets/images/background-$theme.png'),
        fit: BoxFit.fill
    );

    static OutlinedScoreText scoreText(score) => OutlinedScoreText(
        "$score", 
        font: 'Flappy-Bird-Score', 
        fontSize: 70, 
        textColor: Colors.white, 
        strokeColor: Colors.black, 
        strokeWidth: 100
    );

    static OutlinedText getReadyText = OutlinedText(
            "Get Ready!", 
            font: 'Flappy-Bird', 
            fontSize: 90,
            textColor: Colors.greenAccent.shade700, 
            strokeColor: Colors.white, 
            strokeWidth: 6
        );

    static AboutDialog aboutDialog = AboutDialog(
        applicationVersion: "v0.0.1",
        applicationName: "Flappy Bird (De)Lite",
        applicationLegalese: "Created for purely educational purposes, based on the original game created by Dong Nguyen. \n\n It's just like Flappy Bird, but worse.",
    );

}

