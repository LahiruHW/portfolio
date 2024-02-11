import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toasties_flutter/common/entity/message.dart';
import 'package:toasties_flutter/common/utility/toasties_firestore_services.dart';

class Chat {
  late String chatName;
  late List<Message> msgs;
  late Timestamp timeSaved;
  late String chatID; // if saved before, this field will be populated

  Chat({
    required this.chatName,
    required this.msgs,
    required this.timeSaved,
    required this.chatID,
  });

  void addMessage(Message message) {
    msgs.add(message);
    timeSaved = message.timeCreated;
  }

  factory Chat.fromMap(Map<String, dynamic> json) {
    return Chat(
      chatName: json['chatName'],
      msgs: List<Message>.from(json['msgs']?.map((x) => Message.fromMap(x))),
      timeSaved: json['timeSaved'],
      chatID: json['chatID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatName': chatName,
      'msgs': msgs.isEmpty
          ? FieldValue.arrayUnion([])
          : msgs.map((x) => x.toMap()).toList(),
      'timeSaved': timeSaved,
      'chatID': chatID,
    };
  }

  /// used for firebase storage
  factory Chat.fromJson(Map<String, dynamic> json) {
    // convert string to timestamp
    final timeSaved = Timestamp.fromDate(DateTime.parse(json['timeSaved']));
    return Chat(
      chatName: json['chatName'],
      msgs: List<Message>.from(json['msgs']?.map((x) => Message.fromJson(x))),
      timeSaved: timeSaved,
      chatID: json['chatID'],
    );
  }

  /// used for firebase storage
  Map<String, dynamic> toJson() {
    // convert timestamp to string
    final timeSavedString = timeSaved.toDate().toString();
    return {
      'chatName': chatName,
      'msgs': msgs.isEmpty ? [] : msgs.map((x) => x.toJson()).toList(),
      'timeSaved': timeSavedString,
      'chatID': chatID,
    };
  }

  /// only used when creating a new chat to replace the current chat
  factory Chat.empty({
    String? newChatName = "New Consultation",
  }) {
    final newChatID = ToastiesFirestoreServices.chatCollection.doc().id;
    return Chat(
      chatName: newChatName!,
      msgs: [],
      timeSaved: Timestamp.now(),
      chatID: newChatID,
    );
  }

  @override
  String toString() {
    return 'Chat: {chatName: $chatName, lastMesage: ${msgs == <Message>[] ? msgs.last : "NULL"}, msgCount: ${msgs == <Message>[] ? 0 : msgs.length}, timeSaved: $timeSaved, chatID: $chatID}';
  }
}
