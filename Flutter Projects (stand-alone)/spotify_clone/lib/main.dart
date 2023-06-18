// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/providers/global_state_provider.dart';
import 'package:spotify_clone/utilities/route_manager.dart';
import 'package:spotify_clone/screens/welcome_screen.dart';
import 'firebase_options.dart';

/// TIPS TO REMEMBER:
/// 1. Pop off unnecessary screens from the stack when navigating to the home screen (it saves space!)
/// 2. Use snackbars whenever possible
/// 3. Keep track of all the routes so that you don't lose track of where you are
/// 4. Refactor all the code to make it more readable
/// 5. Have a global app_theme file to store all the theme data (colors, fonts, etc.)
/// 6. ??

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SpotifyCloneApp());
}

class SpotifyCloneApp extends StatelessWidget {
  static GlobalKey mainAppKey = GlobalKey();
  const SpotifyCloneApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SpotifyUserStateProvider(),
        ),
      ],
      child: Consumer<SpotifyUserStateProvider>(
        builder: (context, spotifyUserStateProvider, child) {
          return MaterialApp(
            key: SpotifyCloneApp.mainAppKey,
            scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
            onGenerateRoute: (settings) =>
                SpotifyRouteManager.goToScreen(settings),
            color: const Color.fromARGB(166, 27, 26, 28),
            debugShowCheckedModeBanner: false,
            home:
                const WelcomeScreen(), // route to both login and sign up pages
          );
        },
      ),
    );
  }
}
