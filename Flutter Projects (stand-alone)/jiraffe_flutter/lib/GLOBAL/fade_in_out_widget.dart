import 'package:flutter/material.dart';

class FadeInOutWidget extends StatefulWidget {
  const FadeInOutWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  FadeInOutWidgetState createState() => FadeInOutWidgetState();
}

class FadeInOutWidgetState extends State<FadeInOutWidget> with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Create a Tween animation
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    // Start the fade-in animation
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is destroyed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
