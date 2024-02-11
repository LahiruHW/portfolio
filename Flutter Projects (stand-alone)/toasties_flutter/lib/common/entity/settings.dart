// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class UserSettings {
  late bool isDarkMode;
  late Timestamp? lastUpdated;
  late String? lastUpdatedString;

  UserSettings({
    this.isDarkMode = false,
    this.lastUpdated,
    this.lastUpdatedString,
  });

  void updateSettings({
    bool? isDarkMode,
    DateTime? lastUpdated,
    String? lastUpdatedString,
  }) {
    final currrentTimeStamp = Timestamp.now();
    final currrentTimeStampString =
        currrentTimeStamp.toDate().toIso8601String(); // for debugging

    this.isDarkMode = isDarkMode ?? this.isDarkMode;
    this.lastUpdated = currrentTimeStamp;
    this.lastUpdatedString = currrentTimeStampString;
    print('Settings updated: $this');
  }

  factory UserSettings.fromMap(Map<String, dynamic> json) {
    return UserSettings(
      isDarkMode: json['isDarkMode'],
      lastUpdated: json['lastUpdated'],
      lastUpdatedString: json['lastUpdatedString'],
    );
  }

  Map<String, dynamic> toMap() => {
        'isDarkMode': isDarkMode,
        'lastUpdated': lastUpdated ?? Timestamp.now(),
      };

  /// used for firebase storage
  factory UserSettings.fromJson(Map<String, dynamic> json) {
    // convert string to timestamp
    final lastUpdatedTemp = Timestamp.fromDate(
      DateTime.parse(json['lastUpdated']),
    );
    return UserSettings(
      isDarkMode: json['isDarkMode'],
      lastUpdated: lastUpdatedTemp,
      lastUpdatedString: json['lastUpdatedString'],
    );
  }

  /// used for firebase storage
  Map<String, dynamic> toJson() {
    // convert timestamp to string
    final timestampStr = (lastUpdated ?? Timestamp.now()).toDate().toString();
    return {
      'isDarkMode': isDarkMode,
      'lastUpdated': timestampStr,
    };
  }

  @override
  String toString() {
    return 'Settings: {isDarkMode: $isDarkMode, lastUpdated: $lastUpdated, lastUpdatedString: $lastUpdatedString}';
  }
}
