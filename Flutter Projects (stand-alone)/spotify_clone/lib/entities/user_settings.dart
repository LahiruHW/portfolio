
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
  List devices;
  bool showLocalDevicesOnly;
  bool spotifyConnectInBackground;

  // 

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



  toJson() {
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
    return UserSettings(
      userID: json["userID"],
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
      devices: json["devices"],
      showLocalDevicesOnly: json["showLocalDevicesOnly"],
      spotifyConnectInBackground: json["spotifyConnectInBackground"],
    );
  }

}
