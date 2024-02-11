import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toasties_flutter/LAILA/engine.dart';
import 'package:toasties_flutter/common/constants/enum_login_types.dart';
import 'package:toasties_flutter/common/entity/index.dart';
import 'package:toasties_flutter/common/utility/toastie_auth.dart';
import 'package:toasties_flutter/common/utility/toastie_storage_services.dart';
import 'package:toasties_flutter/common/utility/toasties_firestore_services.dart';

/// Provider for the current user instance
class ToastieStateProvider extends ChangeNotifier {
  User? user;
  UserLocalProfile userProfile = UserLocalProfile(settings: UserSettings());
  Chat? currentChat;
  List<Chat> savedChats = [];
  final authService = ToastiesAuthService();

  ToastieStateProvider() {
    authService.onAuthStateChanged.listen(
      (User? newUser) => newUser != null ? setUserInstance(newUser) : null,
    );

    debugPrint('------------------------------ StateProvider initialized');
  }

  /// calls the sign in with email and password method from the auth service
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await authService.signInWithEmailAndPassword(email, password).then(
      (userCred) async {
        final dataMap = await ToastiesFirestoreServices.setupUserProfile(
            userCred.user!.uid, null);
        userProfile = dataMap['userProfile'] as UserLocalProfile;
        currentChat = dataMap['currentChat'] as Chat;
        savedChats = (dataMap['savedChats'] as List)
            .map((e) => Chat.fromMap(e))
            .toList();
        convertCurrentChatToContentList();
        notifyListeners();
      },
    ).onError(
      (error, stackTrace) => throw Exception(error),
    );
  }

  /// calls the sign in with google method from the auth service
  Future<void> signInWithGoogle() async {
    await authService.signInWithGoogle().then(
      (userCred) async {
        final dataMap = await ToastiesFirestoreServices.setupUserProfile(
          userCred.user!.uid,
          null,
          loginType: LoginType.google,
        );
        userProfile = dataMap['userProfile'] as UserLocalProfile;
        currentChat = dataMap['currentChat'] as Chat;
        savedChats = (dataMap['savedChats'] as List)
            .map((e) => Chat.fromMap(e))
            .toList();
        convertCurrentChatToContentList();
        notifyListeners();
      },
    ).onError(
      (error, stackTrace) => throw Exception(error),
    );
  }

  /// calls the sign up with email and password method from the auth service
  /// and then sets the user instance, effectively logging the user in
  Future<void> signUpWithLegalEaseAccount(
      String email, String password, String? userName) async {
    await authService
        .signUpWithLegalEaseAccount(email, password, userName)
        .then(
      (userCred) async {
        final dataMap = await ToastiesFirestoreServices.setupUserProfile(
            userCred.user!.uid, userName);
        userProfile = dataMap['userProfile'] as UserLocalProfile;
        currentChat = dataMap['currentChat'] as Chat;
        savedChats = (dataMap['savedChats'] as List)
            .map((e) => Chat.fromMap(e))
            .toList();
        convertCurrentChatToContentList();
        notifyListeners();
      },
    ).onError(
      (error, stackTrace) => throw Exception(error),
    );
  }

  void addToCurrentChat(Message msg) {
    currentChat!.addMessage(msg);
    notifyListeners();
  }

  void saveCurrentChat() {
    savedChats.add(currentChat!);
    // update the current chat in the database
    // then clear the current chat from t
    currentChat = null;
    currentChat = Chat.empty();
    notifyListeners();
  } 

  void convertCurrentChatToContentList() {
    LAILA.getContentListFromChat(currentChat!);
    debugPrint(
        '------------------------------ currentChat converted to content list');
  }


  /// set all the user instance data after login or signup
  void setUserInstance(User user) async {
    this.user = user;
    debugPrint('------------------------------ StateProvider user set');
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut().then(
          (value) => clearUserInstance(),
        );
  }

  /// clear the user instance and all user data after sign out
  void clearUserInstance() async {
    user = null;
    userProfile = UserLocalProfile(settings: UserSettings());
    currentChat = null;
    savedChats = [];
    LAILA.shutdownEngine();
    debugPrint(
        '------------------------------ StateProvider user signed out & cleared');
    notifyListeners();
  }

  /// refresh the state of the user
  Future<void> refreshUser() async {
    await user!.reload();
    notifyListeners();
  }

  /// update the user's profile data via the state provider
  void updateSettings({
    bool? isDarkMode,
  }) {
    userProfile.settings.updateSettings(
      isDarkMode: isDarkMode,
    );
    notifyListeners();
  }

  /// update the chat folder in the database with the user's current chat data
  Future<void> updateCurrentChatInFirebaseStorageTEMP() async {
    currentChat!.timeSaved = Timestamp.now();
    final userID = user!.uid;
    final currentChatData = currentChat!.toJson();
    debugPrint('----------------- updated current chat in firebase storage');

    return await ToastiesFirebaseStorageServices.writeCurrentChatFile(
      userID,
      currentChat!.chatID,
      currentChatData,
    );
  }
}
