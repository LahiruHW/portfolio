import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toasties_flutter/common/widgets/msg_bubble.dart';

class Message {
  Message({
    required this.timeCreated,
    required this.isMsgUser,
    required this.content,
  });

  Timestamp timeCreated;
  bool isMsgUser;
  String content;

  ToastieChatBubble toChatBubble({TextStyle? style}) {
    return ToastieChatBubble(
      isMsgUser: isMsgUser,
      child: Text(
        content,
        style: style!.copyWith(
          color: isMsgUser ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeCreated': timeCreated,
      'isMsgUser': isMsgUser,
      'content': content,
    };
  }

  factory Message.fromMap(Map<String, dynamic> json) {
    return Message(
      isMsgUser: json['isMsgUser'],
      content: json['content'],
      timeCreated: json['timeCreated'],
    );
  }

  /// used for firebase storage
  Map<String, dynamic> toJson() {
    // convert timestamp to string
    final timeCreatedString = timeCreated.toDate().toString();
    return {
      'timeCreated': timeCreatedString,
      'isMsgUser': isMsgUser,
      'content': content,
    };
  }

  /// used for firebase storage
  factory Message.fromJson(Map<String, dynamic> json) {
    // convert string to timestamp
    final timeCreated = Timestamp.fromDate(DateTime.parse(json['timeCreated']));
    return Message(
      isMsgUser: json['isMsgUser'],
      content: json['content'],
      timeCreated: timeCreated,
    );
  }

  @override
  String toString() {
    final timeInfo = timeCreated.toDate().toString();
    return 'Message: {$timeInfo --> ${isMsgUser ? "User" : "LAILA"} : $content}';
  }
}
