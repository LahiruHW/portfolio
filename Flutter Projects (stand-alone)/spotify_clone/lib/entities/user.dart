
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

  String profilePicLink = "";

  SpotifyUser({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.settings,
    this.userID = "",
    this.profilePicLink = "", // firestore link for the profile pic
  });

  void setID(String id) {
    userID = id;
  }

  void setProfilePic(String link) {
    profilePicLink = link;
  }

  Map<String, dynamic> toJson({String? userID = "", String? profilePic = ""}) {
    return {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "settings": settings.toJson(userID: userID),
      "userID": userID,
      "profilePicLink": profilePic,
    };
  }

  factory SpotifyUser.fromJson(Map<String, dynamic> json) {
    late Map<String, dynamic> theseSettings;
    late String thisID;
    late String thisProfilePic;

    if (json["settings"].isEmpty) {
      final newSettings = UserSettings();
      theseSettings = newSettings.toJson();
    } else {
      theseSettings = (json["settings"]);
    }

    if (json["userID"] == null) {
      thisID = "";
    } else {
      thisID = json["userID"];
    }

    if (json["profilePicLink"] == null) {
      thisProfilePic = "";
    } else {
      thisProfilePic = json["profilePicLink"];
    }

    return SpotifyUser(
      email: json["email"],
      password: json["password"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      gender: json["gender"],
      settings: UserSettings.fromJson(theseSettings),
      userID: thisID,
      profilePicLink: thisProfilePic,
    );
  }
}
