import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/widgets/animating_gradient_backdrop.dart';

class BaseEntrace extends StatefulWidget {
  const BaseEntrace({
    super.key,
    this.bodyWidget,
  });

  final Widget? bodyWidget;

  @override
  State<BaseEntrace> createState() => _BaseEntraceState();
}

class _BaseEntraceState extends State<BaseEntrace> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const AnimGradientBackdrop(),
            widget.bodyWidget!,
          ],
        ),
      ),
    );
  }
}
