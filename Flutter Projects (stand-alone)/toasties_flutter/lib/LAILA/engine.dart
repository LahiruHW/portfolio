// REFER TO THESE SECTIONS FOR HOW TO USE THE GEMINI API:
// https://pub.dev/packages/flutter_gemini#:~:text=list%20of%20images-,Multi%2Dturn%20conversations%20(chat),-Using%20Gemini%2C%20you

// ignore_for_file: implementation_imports, unused_element

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:toasties_flutter/common/constants/env4toasties.dart';
import 'package:toasties_flutter/common/entity/chat.dart';
import 'package:toasties_flutter/common/entity/message.dart';

/// LAILA is the AI that powers the chatbot.
/// This engine code is based on the Gemini API, and interacts with the user's firebase data.
class LAILA {
  LAILA._();

  static final Gemini gemini = Gemini.instance;

  static late List<Content> currentChatContentList;

  static void init() {
    Gemini.init(
      apiKey: ToastiesEnv.geminiApiKey,
      enableDebugging: true,
    );
    currentChatContentList = [];
  }

  static void getContentListFromChat(Chat chat) {
    
    List<Content> tempContentList = [];
    
    for (var msg in chat.msgs) {
      if (msg.isMsgUser) {
        tempContentList.add(_getUserContent(msg));
      } else {
        tempContentList.add(_getLAILAContent(msg));
      }
    }

    // if (tempContentList.isNotEmpty && tempContentList.last.role == 'model') {
    //   final resumeMsg = Message(
    //     timeCreated: Timestamp.now(),
    //     isMsgUser: true,
    //     content: "Let's resume this conversation, shall we?",
    //   );
    //   tempContentList.add(_getUserContent(resumeMsg));
    // }

    currentChatContentList.addAll(tempContentList);
    tempContentList.clear();

  }

  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////

  static Future<void> getAllInitContent() async {
    await gemini.chat(currentChatContentList).then((candidate){
      currentChatContentList.add(candidate!.content!);
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////

  /// a message sent from the user - allow sending image data
  static Content _getUserContent(Message message, {Object? extra}) {
    return Content(
      parts: [
        Parts(
          text: message.content,
        )
      ],
      role: 'user',
    );
  }

  /// a message sent from LAILA - allow image data to be received
  static Content _getLAILAContent(Message message, {Object? extra}) {
    return Content(
      parts: [
        Parts(
          text: message.content,
        )
      ],
      role: 'model',
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////

  /// Turn off the engine when the app is closed or when the current user is logged out
  static void shutdownEngine() {
    currentChatContentList.clear();
  }
}
