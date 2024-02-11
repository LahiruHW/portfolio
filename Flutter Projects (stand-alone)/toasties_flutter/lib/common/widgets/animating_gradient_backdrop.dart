import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';

class AnimGradientBackdrop extends StatefulWidget {
  const AnimGradientBackdrop({
    super.key,
  });

  @override
  AnimGradientBackdropState createState() => AnimGradientBackdropState();
}

class AnimGradientBackdropState extends State<AnimGradientBackdrop> {
  @override
  void initState() {
    super.initState();
    //
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: AnimateGradient(
        duration: const Duration(seconds: 5),
        animateAlignments: true,
        reverse: true,
        primaryBegin: Alignment.topCenter,
        primaryEnd: Alignment.bottomCenter,
        primaryColors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.surface,
        ],
        secondaryColors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.onBackground,
          Theme.of(context).colorScheme.primary,
        ],

      ),
    );
  }
}
