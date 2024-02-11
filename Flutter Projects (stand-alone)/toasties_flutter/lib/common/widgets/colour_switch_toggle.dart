import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/state_provider.dart';
// import 'package:toasties_flutter/common/providers/state_provider.dart';

class ToastiesThemeModeToggle extends StatefulWidget {
  const ToastiesThemeModeToggle({
    super.key,
    this.isDarkMode = true,
  });

  final bool isDarkMode;

  @override
  State<ToastiesThemeModeToggle> createState() =>
      _ToastiesThemeModeToggleState();
}

class _ToastiesThemeModeToggleState extends State<ToastiesThemeModeToggle> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToastieStateProvider>(context, listen: false);
    return SizedBox(
      child: AnimatedToggleSwitch<bool>.dual(
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        current: provider.userProfile.settings.isDarkMode,
        first: true,
        second: false,
        spacing: 5,
        height: 40,
        fittingMode: FittingMode.preventHorizontalOverlapping,
        iconBuilder: (bool value) => Icon(
          value ? Icons.nightlight_round : Icons.wb_sunny_rounded,
          size: 20,
        ),
        textBuilder: (bool value) => Icon(
          value ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          size: 20,
        ),
        styleBuilder: (val) => ToggleStyle(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.5),
          borderColor: Colors.transparent,
          indicatorColor: Theme.of(context).colorScheme.primary.withGreen(100),
        ),
        onTap: (prop) => setState(() {
          if (prop.tapped != null) {
            // provider.updateSettings(isDarkMode: prop.tapped!.value);
            provider.updateSettings(isDarkMode: prop.tapped!.value);
          }
        }),
        onChanged: (val) => setState(
          () => provider.updateSettings(isDarkMode: val),
        ),
      ),
    );
  }
}
