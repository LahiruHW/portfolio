
import 'package:flutter/material.dart';
import 'package:simple_animations/stateless_animation/custom_animation.dart';


class LoopingBase extends StatefulWidget {

  _LoopingBaseState ret = _LoopingBaseState();

  void start() async {
    // ignore: await_only_futures
    await ret.start();
  }

  void stop() async {
    await ret.stop();
  }

  @override
  State<LoopingBase> createState() => ret;
}

class _LoopingBaseState extends State<LoopingBase> {

    static const int time = 3;

    late CustomAnimationControl _control = CustomAnimationControl.stop;

    final base = Container(
        alignment: Alignment.bottomCenter,
        foregroundDecoration: BoxDecoration(
            image: DecorationImage(
                // colorFilter: ColorFilter.mode(Colors.greenAccent.shade400.withOpacity(0.2), BlendMode.darken),
                alignment: Alignment(0 , 1),
                image: AssetImage('assets/images/base.png'),
                fit: BoxFit.fitWidth
            )
        ),
    );

  Future<int> start() async{
    setState(() {
        _control = CustomAnimationControl.loop;  
    });
    return 1;
  }

  Future<int> stop() async{
    setState(() {
        _control = CustomAnimationControl.stop;  
    });
    return 1;
  }

  @override
  Widget build(BuildContext context) {
      return Stack(
          children: [
              CustomAnimation<double>(
                  control: _control,
                  duration: const Duration(seconds: time),
                  tween: Tween( begin: 0, end: MediaQuery.of(context).size.width ),
                  builder: (context, child, value) { 
                      return Transform.translate(
                          child: child,
                          offset: Offset(-value, 0),
                      );
                  },
                  child: base
              ),
              CustomAnimation<double>(
                  control: _control,
                  duration: const Duration(seconds: time),
                  tween: Tween( begin: MediaQuery.of(context).size.width*-1, end: 0),
                  builder: (context, child, value) { 
                      return Transform.translate(
                          child: child,
                          offset: Offset(-value, 0),
                      );
                  },
                  child: base
              ),
          ],

      );
    
  }
}




