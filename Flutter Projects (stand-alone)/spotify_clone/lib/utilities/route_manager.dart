import 'package:flutter/material.dart';

import 'create_route_to.dart';
import 'package:spotify_clone/screens/login_screen.dart';
import 'package:spotify_clone/screens/sign_up/enter_email_screen.dart';
import 'package:spotify_clone/screens/sign_up/enter_gender_screen.dart';
import 'package:spotify_clone/screens/sign_up/enter_name_screen.dart';
import 'package:spotify_clone/screens/sign_up/enter_password_screen.dart';
import 'package:spotify_clone/screens/sign_up/select_artists_screen.dart';
import 'package:spotify_clone/screens/welcome_screen.dart';

class SpotifyRouteManager {
  static Route<dynamic>? goToScreen(RouteSettings settings) {
    if (settings.name == WelcomeScreen.routeName) {
      return createRouteTo(const WelcomeScreen(), settings);
    }
    if (settings.name == EnterEmailScreen.routeName) {
      return createRouteTo(const EnterEmailScreen(), settings);
    }
    if (settings.name == EnterPasswordScreen.routeName) {
      return createRouteTo(const EnterPasswordScreen(), settings);
    }
    if (settings.name == EnterGenderScreen.routeName) {
      return createRouteTo(const EnterGenderScreen(), settings);
    }
    if (settings.name == EnterNameScreen.routeName) {
      return createRouteTo(const EnterNameScreen(), settings);
    }
    if (settings.name == SelectArtistScreen.routeName) {
      return createRouteTo(const SelectArtistScreen(), settings);
    }
    if (settings.name == LoginScreen.routeName) {
      return createRouteTo(const LoginScreen(), settings);
    }
    // return MaterialPageRoute(builder: (context) => const WelcomeScreen());
    return null;
  }
}
