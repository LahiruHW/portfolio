// ignore_for_file: avoid_print

// import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/state_provider.dart';
import 'package:toasties_flutter/common/utility/toastie_auth.dart';
import 'package:toasties_flutter/common/widgets/colour_switch_toggle.dart';
import 'package:toasties_flutter/common/widgets/google_action_button.dart';
import 'package:toasties_flutter/common/widgets/legalease_action_button.dart';

/// Provides options to either signup/login with a Google or LegalEase User Account
class LoginTypeSelectPage extends StatefulWidget {
  const LoginTypeSelectPage({
    super.key,
  });

  @override
  State<LoginTypeSelectPage> createState() => _LoginTypeSelectPageState();
}

class _LoginTypeSelectPageState extends State<LoginTypeSelectPage> {
  User? user;
  ToastiesAuthService authService = ToastiesAuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "LegalEase",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 40,
                    ),
              ),
              const SizedBox(height: 15),
              GoogleActionButton(
                onPressed: () {
                  final authProvider =
                      Provider.of<ToastieStateProvider>(context, listen: false);
                  authProvider.signInWithGoogle().then(
                    (value) {
                      Future.delayed(
                        const Duration(milliseconds: 1500),
                        () => GoRouter.of(context).go("/home"),
                      );
                    },
                  );
                }, // update the user state
                title: "Login with Google",
                titleColor: Theme.of(context)
                            .colorScheme
                            .background
                            .computeLuminance() <
                        0.5
                    ? Colors.black
                    : Colors.white,
              ),
              const SizedBox(height: 15),
              LegalEaseActionButton(
                onPressed: () => GoRouter.of(context).push("/login-uac"),
                title: "Login with LegalEase account",
                titleColor: Theme.of(context)
                            .colorScheme
                            .background
                            .computeLuminance() <
                        0.5
                    ? Colors.black
                    : Colors.white,
              ),
              const SizedBox(height: 15),
              RichText(
                textWidthBasis: TextWidthBasis.longestLine,
                maxLines: 2,
                textAlign: TextAlign.center,
                softWrap: false,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "No user account? ",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    TextSpan(
                      text: "Click here",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint("===================== Sign-up clicked");
                          GoRouter.of(context).push("/signup-uac");
                        },
                    ),
                    TextSpan(
                      text: " to Sign-Up ",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              const ToastiesThemeModeToggle()
            ]
                .animate(
                  delay: 800.ms,
                  interval: 50.ms,
                )
                .fadeIn(
                  duration: 1000.ms,
                  curve: Curves.easeInOut,
                ),
          ),
        ),
      ),
    );
  }
}
