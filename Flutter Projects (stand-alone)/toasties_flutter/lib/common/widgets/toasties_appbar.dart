import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';

const statusBarHeight = 35.0;

class ToastiesAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// A custom appbar for the LegalEase app that uses the [NavigationToolbar] widget
  /// that deals with the positioning of the [leading], [middle] and [trailing] widgets
  const ToastiesAppBar({
    super.key,
    this.showBackButton = false,
    this.showTitle = true,
    this.trailing,
  });

  final bool showBackButton;
  final bool showTitle;
  final Widget? trailing;

  final gradientDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: <Color>[
        Color.fromRGBO(0, 109, 170, 1.0),
        Color.fromRGBO(0, 65, 131, 1),
      ],
    ),
  );

  final transparentDeco = const BoxDecoration(
    color: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    final canPop = GoRouter.of(context).canPop();

    return Material(
      elevation: 0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox.expand(
            child: Container(
              decoration: gradientDecoration,
            ),
          ),
          Column(
            children: [
              Container(
                height: statusBarHeight,
                width: double.infinity,
                decoration: transparentDeco,
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: gradientDecoration,
                    ),
                    NavigationToolbar(
                      centerMiddle: false,
                      leading: !(showBackButton & canPop)
                          ? null
                          : IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                              ),
                              onPressed: () => showBackButton & canPop
                                  ? GoRouter.of(context).pop()
                                  : null,
                            ),
                      middle: showTitle
                          ? Text(
                              "LegalEase",
                              style:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                            )
                          : null,
                      trailing: trailing,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size(double.infinity, 70); // (width, height) of the appbar
}
