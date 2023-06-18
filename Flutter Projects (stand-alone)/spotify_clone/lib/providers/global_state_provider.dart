import 'package:flutter/material.dart';
import 'package:spotify_clone/entities/user.dart';
import 'package:spotify_clone/entities/user_settings.dart';
import 'package:spotify_clone/services/spotify_services.dart';

// TODO: Refactor all usages of SpotifyServices to this class, so that this provider is only exposed to the app (unless a new account is being made)

/// A class that provides the global state of the User's data and settings to the app.
class SpotifyUserStateProvider extends ChangeNotifier {
  /// The current user logged into the app
  late SpotifyUser currentUser;

  /// The current user's settings
  late UserSettings currentUserSettings;

  void addNewUser(SpotifyUser newUser) async {
    String id = await SpotifyServices.addNewUser(newUser);
    newUser.setID(id);
    setCurrentUser(newUser);                  // setup current user account
    setCurrentUserSettings(newUser.settings); // setup current user settings
  }

  void setCurrentUser(SpotifyUser user) {
    currentUser = user;
    notifyListeners();
  }

  void setCurrentUserSettings(UserSettings settings) {
    currentUserSettings = settings;
    notifyListeners();
  }

  void updateCurrentUserSettings(UserSettings settings) {
    currentUserSettings = settings;
    SpotifyServices.updateUserSettings(currentUser.userID, settings);
    notifyListeners();
  }
}
