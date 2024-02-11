// include all the utility functions for cloud firestore services here as static functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/constants/enum_login_types.dart';
import 'package:toasties_flutter/common/entity/index.dart';
import 'package:toasties_flutter/common/utility/toastie_auth.dart';
import 'package:toasties_flutter/common/utility/toastie_storage_services.dart';
// import 'package:toasties_flutter/common/utility/toastie_storage_services.dart';

class ToastiesFirestoreServices {
  // References to the ddb collections
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final userCollection = firestore.collection('user_profile');
  static final userProfileDocRef = (userId) => userCollection.doc(userId);

  static final chatCollection = firestore.collection('chat');
  static final chatsDocRef = (userId) => chatCollection.doc(userId);
  static final currentchatRef = (userId) => chatsDocRef(userId)
      .get()
      .then((docSnap) => docSnap.data()?["currentChat"]);

  // /////////////////////////////////////////////////////////////////////////////////////////////
  // /////////////////////////////////////////////////////////////////////////////////////////////
  // /////////////////////////////////////////////////////////////////////////////////////////////
  // /////////////////////////////////////////////////////////////////////////////////////////////

  /// initialize user profile - username can be null for a firstime google login
  static Future<Map<String, dynamic>> setupUserProfile(
      String userID, String? userName,
      {LoginType? loginType}) async {
    // only initialize the user profile if it doesn't exist - needed for google login
    final userProfile = await userProfileDocRef(userID).get();

    Map<String, dynamic> returnMap = {
      'userProfile': null,
      'currentChat': null,
      'savedChats': null,
    };

    if (userProfile.exists) {
      debugPrint("--------------- PROFILE ALREADY EXISTS IN FIREBASE");

      final UserLocalProfile userProfile =
          await getUserProfileData(userID).then((userProfileData) {
        final userProfile = UserLocalProfile.fromMap(userProfileData);
        debugPrint("--------------- LOCAL PROFILE: $userProfile");
        return userProfile;
      });

      // first get the current chat id from the firestore and fetch the chat data from the storage
      final Chat currentChat = await getCurrentChatID(userID).then(
        (currentChatID) async =>
            await ToastiesFirebaseStorageServices.getChatFile(
          userID,
          currentChatID,
        ).then((currentChatData) {
          final currentChat = Chat.fromJson(currentChatData);
          debugPrint("--------------- CURRENT CHAT: $currentChat");
          return currentChat;
        }),
      );

      final savedChats = []; // just fetch the saved chats from the storage
      // final List<Chat> savedChats =
      //     await getAllSavedChatData(userID).then((savedChatsData) {
      //   if (savedChatsData.isEmpty) {
      //     debugPrint("--------------- NO SAVED CHATS");
      //     return [];
      //   } else {
      //     final savedChats =
      //         savedChatsData.map((json) => Chat.fromMap(json)).toList();
      //     debugPrint("--------------- SAVED CHATs: $savedChatsData");
      //     return savedChats;
      //   }
      // });

      returnMap['userProfile'] = userProfile;
      returnMap['currentChat'] = currentChat;
      returnMap['savedChats'] = savedChats;

      return returnMap;
    } else {
      // if the new login type is google, generate a random name
      if (loginType == LoginType.google) {
        final newUserName = ToastiesAuthService.getRandomName();
        debugPrint("--------------- GOOGLE LOGIN");
        return initializeNewUserProfile(userID, newUserName);
      }
      return initializeNewUserProfile(userID, userName);
    }
  }

  /// initialize a new user's profile data
  static Future<Map<String, dynamic>> initializeNewUserProfile(
    String userID,
    String? userName,
  ) async {
    final newSettings = UserSettings();
    final userProfile = UserLocalProfile(
      userName: userName,
      settings: newSettings,
    );

    String newChatID = chatCollection.doc().id;
    print("????????????????????????????????????????? $newChatID");

    final newCurrentChat = Chat(
      chatID: newChatID,
      chatName: "New Consultation",
      timeSaved: Timestamp.now(),
      msgs: [],
    );
    final firestoreChatDocMap = {
      'currentChatID': newChatID,
      'savedChatsIDs': FieldValue.arrayUnion([]),
    };

    final savedChats = [];

    Map<String, dynamic> returnMap = {
      'userProfile': userProfile,
      'currentChat': newCurrentChat,
      'savedChats': savedChats,
    };

    await userProfileDocRef(userID).set(userProfile.toMap());

    // await chatsDocRef(userID).set({
    //   'currentChat': newCurrentChat.toMap(),
    // });
    await chatsDocRef(userID).set(firestoreChatDocMap);

    await ToastiesFirebaseStorageServices.createNewChatFolder(
      userID: userID,
      newCurrentChatID: newChatID,
      currentChatMap: newCurrentChat.toJson(),
    );

    // await savedChatCollection(userID).doc("default").set({
    //   'alert': "DO NOT READ THIS DOCUMENT",
    // });

    return returnMap;
  }

  /// get a Future of the user's cloud firestore profile data
  static Future<Map<String, dynamic>> getUserProfileData(String userID) {
    // if docs with the userID as the docID exists,
    // return the data as a Map<String, dynamic>
    return userProfileDocRef(userID).get().then((docSnap) {
      var data = docSnap.data() as Map<String, dynamic>;
      if (docSnap.exists) {
        return Future<Map<String, dynamic>>.value(data);
      } else {
        return Future<Map<String, dynamic>>.value({});
      }
    });
  }

  /// get a Future of the user's currentChat data from firestore
  static Future<String> getCurrentChatID(String userID) {
    return chatsDocRef(userID).get().then((docSnap) {
      var data = docSnap.data()?["currentChatID"] as String;
      if (docSnap.exists) {
        return Future<String>.value(data);
      } else {
        return Future<String>.value("");
      }
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////

  /// update the user's profile data
  static Future<void> updateUserProfileData(
      String userID, Map<String, dynamic> data) {
    return userProfileDocRef(userID).update(data);
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////

}
