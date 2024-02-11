import 'package:toasties_flutter/common/entity/index.dart';

class UserLocalProfile {
  late String? userName;
  UserSettings settings;

  UserLocalProfile({
    this.userName = "",
    required this.settings,
  });

  factory UserLocalProfile.fromMap(Map<String, dynamic> json) {
    return UserLocalProfile(
      userName: json['userName'],
      settings: UserSettings.fromMap(json['settings']),
    );
  }

  Map<String, dynamic> toMap() =>
      {'userName': userName, 'settings': settings.toMap()};

  /// used for firebase storage
  Map<String, dynamic> toJson() =>
      {'userName': userName, 'settings': settings.toJson()};

  /// used for firebase storage
  factory UserLocalProfile.fromJson(Map<String, dynamic> json) {
    return UserLocalProfile(
      userName: json['userName'],
      settings: UserSettings.fromJson(json['settings']),
    );
  }

  @override
  String toString() {
    return 'UserLocalProfile: {userName: $userName, $settings}';
  }
}
