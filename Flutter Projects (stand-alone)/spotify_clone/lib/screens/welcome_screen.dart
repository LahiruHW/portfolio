import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/screens/login_screen.dart';
import 'package:spotify_clone/screens/sign_up/enter_email_screen.dart';
import '../components/button_login.dart';

class WelcomeScreen extends StatelessWidget {
  /// The main entry point for the application, directing
  /// the user to login using their preferred method.
  const WelcomeScreen({
    super.key,
  });

  static const String routeName = "/welcome_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: const Color.fromARGB(166, 27, 26, 28),
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1.0),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/backgrounds/login_background_edit2.png",
            fit: BoxFit.fitWidth,
            scale: 2.0,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 50.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Millions of Songs.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: "Avenir Next",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 15.0,
                    ),
                    child: Text(
                      "Free on Spotify.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: "Avenir Next",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  LoginButton(
                    height: 70,
                    onPressed: () {
                      print("------------------------------- Sign Up For Free");
                      print("Next screen: ${EnterEmailScreen.routeName}");
                      Navigator.of(context).pushNamed(
                        EnterEmailScreen.routeName,
                      );
                    },
                    borderColor: Colors.transparent,
                    backgroundColor: const Color.fromARGB(255, 30, 215, 96),
                    textColor: Colors.black,
                    text: "Sign Up For Free",
                  ),
                  LoginButton(
                    height: 70,
                    onPressed: () {
                      print("--------------------------- Continue with Google");
                    },
                    backgroundColor: const Color.fromARGB(255, 27, 26, 28),
                    borderColor: Colors.white,
                    text: "Continue with Google",
                    textColor: Colors.white,
                    headerIcon: Image.asset(
                        "assets/images/logos/google_colour.png",
                        scale: 1.6),
                  ),
                  LoginButton(
                    height: 70,
                    onPressed: () {
                      print("------------------------- Continue with Facebook");
                    },
                    backgroundColor: const Color.fromARGB(255, 27, 26, 28),
                    borderColor: Colors.white,
                    text: "Continue with Facebook",
                    textColor: Colors.white,
                    headerIcon: Image.asset(
                        "assets/images/logos/facebook_colour.png",
                        scale: 1.6),
                  ),
                  LoginButton(
                    height: 70,
                    onPressed: () => print(
                        "------------------------------- Continue with Apple"),
                    backgroundColor: const Color.fromARGB(255, 27, 26, 28),
                    borderColor: Colors.white,
                    text: "Continue with Apple",
                    textColor: Colors.white,
                    headerIcon: Image.asset(
                        "assets/images/logos/apple_white.png",
                        scale: 1.6),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pushNamed(
                                LoginScreen.routeName,
                              ),
                        text: "Log In",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Avenir Next",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
