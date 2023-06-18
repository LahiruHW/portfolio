// ignore_for_file: unused_import, avoid_print, invalid_return_type_for_catch_error, library_prefixes

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone/entities/user.dart';
import 'package:spotify_clone/entities/user_settings.dart';
import 'package:encrypt/encrypt.dart' as ENCRYPT;

class SpotifyServices {
  // ignore: unused_field
  static const String _secureKey = "4w17TWFLDUcHRcd4BReeRQ==";

  static String userPath = "/users";

  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  static Future<String> addNewUser(SpotifyUser newUser) async {
    final response = await userCollection
        .add(newUser.toJson())
        .catchError((error) => print("Failed to add user: $error"));

    final userID = response.id;
    final profilePicLink = newUser.profilePicLink;

    // update the user's ID in the "settings" field in the firestore DB
    userCollection.doc(userID).update({
      ...newUser.toJson(userID: userID, profilePic: profilePicLink),
      "userID": userID,
      "settings": {
        ...newUser.settings.toJson(),
        "userID": userID,
      },
    });

    return userID;
  }

  /// Verify if a user exists in the database
  static Future<bool> verifyUser(String email, String password) async {
    password = await encryptPassword(password);
    final response = await userCollection
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();
    return response.docs.isNotEmpty;
  }

  /// Get the user from the database, based on the user ID
  static Future<SpotifyUser> getUserByID(String userID) async {
    final response = await userCollection.doc(userID).get();
    final receivedUser =
        SpotifyUser.fromJson(response.data() as Map<String, dynamic>);
    return receivedUser;
  }

  static Future<SpotifyUser> getUserByDetails(
      String email, String password) async {
    password = await encryptPassword(password);
    final response = await userCollection
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();
    final receivedUser = SpotifyUser.fromJson(
        response.docs.first.data() as Map<String, dynamic>);
    return receivedUser;
  }

  static updateUserSettings(String userID, UserSettings settings) async {
    final response = await userCollection.doc(userID).update({
      "settings": settings.toJson(userID: userID),
    }).catchError((error) => print("Failed to update user: $error"));
    return response;
  }

  /// Implement the AES algorithm to encrypt the password
  static Future<String> encryptPassword(String password) async {
    final key = ENCRYPT.Key.fromUtf8(_secureKey);
    final iv = ENCRYPT.IV.fromLength(16);
    final encrypter = ENCRYPT.Encrypter(ENCRYPT.AES(key));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  /// Implement the AES algorithm to decrypt the password
  static Future<String> decryptPassword(String encryptedPassword) async {
    final encryptedPass = ENCRYPT.Encrypted.fromBase64(encryptedPassword);

    final key = ENCRYPT.Key.fromUtf8(_secureKey);
    final iv = ENCRYPT.IV.fromLength(16);
    final encrypter = ENCRYPT.Encrypter(ENCRYPT.AES(key));
    final decrypted = encrypter.decrypt(encryptedPass, iv: iv);
    return decrypted;
  }
}
