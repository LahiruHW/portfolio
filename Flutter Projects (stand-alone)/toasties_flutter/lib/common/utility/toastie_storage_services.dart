// include all the utility functions for firebase storage services here as static functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

// TODO:_ read particular saved chat file into memory

class ToastiesFirebaseStorageServices {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static final userProfileFolderRef = storage.ref().child('user_profile');

  // all the chats of a user are stored in the "chat/{userID}" folder
  static final chatFolderRef = storage.ref().child('chat');
  static final userChatFolderRef =
      (String userID) => chatFolderRef.child('/$userID');
  static final userChatFileRef = (String userID, String chatID) =>
      userChatFolderRef(userID).child('/$chatID.json');

  /// read current chat file of a user
  static Future<Map<String, dynamic>> getChatFile(
    String userID,
    String chatID,
  ) async {
    final fileRef = userChatFileRef(userID, chatID); // get file reference
    final fileData = await fileRef.getData(); // get file data
    final stringData = utf8.decode(fileData!); // convert file data to string
    // convert string data to json
    // final jsonData = json.decode(stringData) as Map<String, dynamic>;
    final jsonData = jsonDecode(stringData) as Map<String, dynamic>;
    return jsonData;
  }

  /// write to current chat file of a user
  static Future<void> writeCurrentChatFile(
    String userID,
    String chatID,
    Map<String, dynamic> currentChatData,
  ) async {
    final fileRef = userChatFileRef(userID, chatID); // get file reference
    final stringData = json.encode(currentChatData); // convert json to string
    final fileData = utf8.encode(stringData); // convert string to file data
    await fileRef.putData(fileData); // write file data to file reference
  }

  /// create a new chat folder that stores all the chats for a new user, also setting the current chat file
  static Future<void> createNewChatFolder({
    required String userID,
    required String newCurrentChatID,
    required Map<String, dynamic> currentChatMap,
  }) async {
    // get a temprary file path in storage
    final tempDir = await getTemporaryDirectory();
    final tempFilePath = tempDir.path;
    final currentChatRef = userChatFileRef(userID, newCurrentChatID);

    ////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////

    // create an empty file name currentChat.json and add some default data
    final currentChatFile =
        await File('$tempFilePath/currentChat.json').create();
    final tempChatString = json.encode(currentChatMap);
    await currentChatFile.writeAsString(tempChatString);
    // convert the file to bytes and upload it to firebase storage
    final bytes = currentChatFile.readAsBytesSync();
    await currentChatRef.putData(bytes);
    await currentChatFile.delete(); // delete it after uploading

    // ////////////////////////////////////////////////////////////////////////////////////////
    // ////////////////////////////////////////////////////////////////////////////////////////

    // // create an empty file name placeholder.json and add some default data
    // final savedChatFile = await File('$tempFilePath/placeholder.json').create();
    // final tempSavedChatData = {
    //   'msg': 'THIS IS A PLACEHOLDER SAVED CHAT',
    // };
    // final tempSavedChatString = json.encode(tempSavedChatData);
    // await savedChatFile.writeAsString(tempSavedChatString);
    // // convert the file to bytes and upload it to firebase storage
    // final savedChatBytes = savedChatFile.readAsBytesSync();
    // final savedChatRef = userSavedChatFileRef(userID, 'placeholder');
    // await savedChatRef.putData(savedChatBytes);
    // await savedChatFile.delete(); // delete it after uploading
  }
}
