import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/providers/global_state_provider.dart';
import 'package:spotify_clone/screens/login_screen.dart';
import 'package:spotify_clone/screens/sign_up/enter_email_screen.dart';
import 'package:spotify_clone/screens/sign_up/enter_gender_screen.dart';
import 'package:spotify_clone/screens/sign_up/enter_name_screen.dart';
import 'package:spotify_clone/screens/sign_up/enter_password_screen.dart';
import 'package:spotify_clone/screens/sign_up/select_artists_screen.dart';
import 'package:spotify_clone/screens/welcome_screen.dart';
import 'package:spotify_clone/utilities/create_route_to.dart';

import 'firebase_options.dart';

/// TIPS TO REMEMBER:
/// 1. Pop off unnecessary screens from the stack when navigating to the home screen (it saves space!)
/// 2. Use snackbars whenever possible
/// 3. Keep track of all the routes so that you don't lose track of where you are
/// 4. Refactor all the code to make it more readable
/// 5. Have a global app_theme file to store all the theme data (colors, fonts, etc.)
/// 6.

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

// ignore: must_be_immutable
class SpotifyCloneApp extends StatelessWidget {
  static GlobalKey mainAppKey = GlobalKey();
  const SpotifyCloneApp({
    super.key,
  });

  // TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // read the global JSON file and set up the app

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
            onGenerateRoute: (settings) {
              if (settings.name == "/welcome_screen") {
                return createRouteTo(const WelcomeScreen(), settings);
              }
              if (settings.name == "/sign_up_email_screen") {
                return createRouteTo(const EnterEmailScreen(), settings);
              }
              if (settings.name == "/sign_up_password_screen") {
                return createRouteTo(const EnterPasswordScreen(), settings);
              }
              if (settings.name == "/sign_up_gender_screen") {
                return createRouteTo(const EnterGenderScreen(), settings);
              }
              if (settings.name == "/sign_up_name-perm_screen") {
                return createRouteTo(const EnterNameScreen(), settings);
              }
              if (settings.name == "/sign_up_select-artist_screen") {
                return createRouteTo(const SelectArtistScreen(), settings);
              }
              if (settings.name == "/login_screen") {
                return createRouteTo(const LoginScreen(), settings);
              }
              // return MaterialPageRoute(builder: (context) => const WelcomeScreen());
              return null;
            },
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
