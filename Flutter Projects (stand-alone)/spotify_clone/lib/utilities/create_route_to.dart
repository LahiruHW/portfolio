import 'package:flutter/material.dart';

Route createRouteTo(Widget newPage, RouteSettings settings) {
  const int transitionTime = 450;
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation1, animation2) => newPage,
    transitionDuration: const Duration(milliseconds: transitionTime),
    barrierColor: const Color.fromARGB(255, 27, 26, 28),
    reverseTransitionDuration: const Duration(milliseconds: transitionTime),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(
        begin: begin,
        end: end,
      ).chain(
        CurveTween(curve: curve),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
