import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_clone/screens/welcome_screen.dart';

/// TIPS TO REMEMBER:
/// 1. Pop off unnecessary screens from the stack when navigating to the home screen (it saves space!)
/// 2. Use snackbars whenever possible
/// 3. Keep track of all the routes so that you don't lose track of where you are
/// 4. Refactor all the code to make it more readable
/// 5. Have a global app_theme file to store all the theme data (colors, fonts, etc.)
/// 6. 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  // hide the status bar
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const SpotifyCloneApp());
}

// ignore: must_be_immutable
class SpotifyCloneApp extends StatelessWidget {
  const SpotifyCloneApp({
    super.key,
  });

  // TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
      color: const Color.fromARGB(166, 27, 26, 28),
      debugShowCheckedModeBanner: false,
      home:
          const WelcomeScreen(), // route here to both the login and sign up pages
    );
  }
}
