// ignore_for_file: unused_element, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  
  late final String id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String password;
  late final String colourHex;

  User({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.colourHex,
  });

  @override
  String toString() {
    return 'User: { id: $id, firstName: $firstName, lastName: $lastName, email: $email, password: $password, colourHex: $colourHex }';
  }

  factory User.fromJson(QueryDocumentSnapshot json, String id) {
    Map<String, dynamic> data = json.data() as Map<String, dynamic>;
    return User(
      id: id,
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      password: data['password'],
      colourHex: data['colourHex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'colourHex': colourHex,
    };
  }


}
