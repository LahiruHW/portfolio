
class UserSettings {
  String userID;

  // under "Data Saver" in Settings
  bool dataSaverAudioQuality;

  // under "Video Podcasts" in Settings
  bool downloadAudiOnly;
  bool streamAudioOnly;

  // under "Playback" in Settings
  bool offlineMode;
  double crossfadeVal;
  bool gaplessPlayback;
  bool autoMix;
  bool allowExplicitContent;
  bool showUnplayableSongs;
  bool normalizeVolume;
  bool monoAudio;
  bool deviceBroadcastStatus;
  bool autoPlay;
  bool canvas;

  // under "Devices" in Settings
  List<String> devices;
  bool showLocalDevicesOnly;
  bool spotifyConnectInBackground;

  // show a message for the rest of the settings "NOT FOR COMMERCIAL USE"

  /// Manages the settings of the app for a particular user
  UserSettings({
    this.userID = "",
    this.dataSaverAudioQuality = false,
    this.downloadAudiOnly = false,
    this.streamAudioOnly = false,
    this.offlineMode = false,
    this.crossfadeVal = 0,
    this.gaplessPlayback = false,
    this.autoMix = false,
    this.allowExplicitContent = false,
    this.showUnplayableSongs = false,
    this.normalizeVolume = false,
    this.monoAudio = false,
    this.deviceBroadcastStatus = false,
    this.autoPlay = false,
    this.canvas = false,
    this.devices = const [],
    this.showLocalDevicesOnly = false,
    this.spotifyConnectInBackground = false,
  });

  Map<String, dynamic> toJson({String? userID = ""}) {
    return {
      "userID": userID,
      "dataSaverAudioQuality": dataSaverAudioQuality,
      "downloadAudiOnly": downloadAudiOnly,
      "streamAudioOnly": streamAudioOnly,
      "offlineMode": offlineMode,
      "crossfadeVal": crossfadeVal,
      "gaplessPlayback": gaplessPlayback,
      "autoMix": autoMix,
      "allowExplicitContent": allowExplicitContent,
      "showUnplayableSongs": showUnplayableSongs,
      "normalizeVolume": normalizeVolume,
      "monoAudio": monoAudio,
      "deviceBroadcastStatus": deviceBroadcastStatus,
      "autoPlay": autoPlay,
      "canvas": canvas,
      "devices": devices,
      "showLocalDevicesOnly": showLocalDevicesOnly,
      "spotifyConnectInBackground": spotifyConnectInBackground,
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    late String thisID;
    List<String> theseDevices = [];

    if (json["userID"] == null) {
      thisID = "";
    } else {
      thisID = json["userID"];
    }

    for (var element in (json["devices"] as List<dynamic>)) {
      theseDevices.add(element.toString());
    }

    return UserSettings(
      userID: thisID,
      dataSaverAudioQuality: json["dataSaverAudioQuality"],
      downloadAudiOnly: json["downloadAudiOnly"],
      streamAudioOnly: json["streamAudioOnly"],
      offlineMode: json["offlineMode"],
      crossfadeVal: json["crossfadeVal"],
      gaplessPlayback: json["gaplessPlayback"],
      autoMix: json["autoMix"],
      allowExplicitContent: json["allowExplicitContent"],
      showUnplayableSongs: json["showUnplayableSongs"],
      normalizeVolume: json["normalizeVolume"],
      monoAudio: json["monoAudio"],
      deviceBroadcastStatus: json["deviceBroadcastStatus"],
      autoPlay: json["autoPlay"],
      canvas: json["canvas"],
      devices: theseDevices,
      showLocalDevicesOnly: json["showLocalDevicesOnly"],
      spotifyConnectInBackground: json["spotifyConnectInBackground"],
    );
  }
}
