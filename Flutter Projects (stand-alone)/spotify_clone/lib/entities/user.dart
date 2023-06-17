import 'package:spotify_clone/entities/user_settings.dart';

/// A class that represents a user entity of the Spotify Clone app.
class SpotifyUser {
  /// The user's email address
  late String email;

  /// The user's password
  late String password;

  /// The user's first name
  late String firstName;

  /// The user's last name
  late String lastName;

  late String gender;

  late UserSettings settings;

  String userID = "";

  SpotifyUser({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.settings,
  });

  void setID(String id) {
    userID = id;
  }

  toJson() {
    return {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "settings": settings.toJson(),
    };
  }

  factory SpotifyUser.fromJson(Map<String, dynamic> json) {
    late Map<String, dynamic> theseSettings;

    if (json["settings"].isEmpty) {
      final newSettings = UserSettings();
      theseSettings = newSettings.toJson();
    } else {
      theseSettings = (json["settings"]);
    }

    return SpotifyUser(
      email: json["email"],
      password: json["password"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      gender: json["gender"],
      settings: UserSettings.fromJson(theseSettings),
    );
  }
}
