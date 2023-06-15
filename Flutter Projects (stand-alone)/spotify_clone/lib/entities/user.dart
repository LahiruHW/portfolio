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

  SpotifyUser({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  toJson() {
    return {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
    };
  }

  SpotifyUser.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
    firstName = json["firstName"];
    lastName = json["lastName"];
  }
}
