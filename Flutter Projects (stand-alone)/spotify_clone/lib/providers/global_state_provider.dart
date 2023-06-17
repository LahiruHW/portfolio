import 'package:flutter/material.dart';
import 'package:spotify_clone/entities/user.dart';
import 'package:spotify_clone/entities/user_settings.dart';

/// A class that provides global state to the app.
class SpotifyUserStateProvider extends ChangeNotifier {
  /// The current user logged into the app
  late SpotifyUser currentUser;

  /// The current user's settings
  late UserSettings currentUserSettings;

  void setCurrentUser(SpotifyUser user) {
    currentUser = user;
    notifyListeners();
  }

  void setCurrentUserSettings(UserSettings settings) {
    currentUserSettings = settings;
    notifyListeners();
  }

}
