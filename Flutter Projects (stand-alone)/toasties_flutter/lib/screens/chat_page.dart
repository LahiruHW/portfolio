import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/entity/index.dart';
import 'package:toasties_flutter/common/providers/state_provider.dart';
import 'package:toasties_flutter/common/widgets/chat_input_group.dart';
import 'package:toasties_flutter/LAILA/engine.dart';
import 'package:toasties_flutter/common/widgets/msg_bubble.dart';
import 'package:toasties_flutter/common/widgets/typing_indicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;
  final GlobalKey<NavigatorState> _chatNavKey = GlobalKey<NavigatorState>();

  bool _loading = false;
  set loading(bool set) => setState(() => _loading = set);
  bool get loading => _loading;

  late final List<Content> chatContent;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController(keepScrollOffset: true);
    chatContent = LAILA.currentChatContentList;
    LAILA
        .getAllInitContent()
        .then(
          (value) => setState(() => chatContent = LAILA.currentChatContentList),
        )
        .onError(
          (error, stackTrace) =>
              setState(() => chatContent = LAILA.currentChatContentList),
        );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    chatContent.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _chatNavKey,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Consumer<ToastieStateProvider>(
          builder: (context, stateProvider, child) => Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  bottom: 60,
                  child: Column(
                    children: [
                      chatContent.isNotEmpty
                          ? Expanded(
                              child: StreamBuilder(
                                initialData: LAILA.gemini.chat(chatContent),
                                stream: LAILA.gemini.streamChat(chatContent),
                                builder: (context, snapshot) {
                                  return ListView.builder(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    itemCount: chatContent.length,
                                    itemBuilder: (context, index) {
                                      // check if the text is empty
                                      if (chatContent[index]
                                          .parts!
                                          .last
                                          .text!
                                          .isEmpty) {
                                        return null;
                                      } else {
                                        return ToastieChatBubble.fromContent(
                                          chatContent[index],
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            )
                          : Container(),
                      /////////////////////////////////////////////
                      TypingIndicator(loading: loading),
                    ],
                  ),
                ),
                ChatInputGroup(
                  textController: _textController,
                  onSave: () {
                    // print('======================= current Chat saved(?)');
                    // print('======================= $chatContent');
                    // print('===================== ${stateProvider.currentChat}');
                    // stateProvider.saveCurrentChat();
                    stateProvider.updateCurrentChatInFirebaseStorageTEMP();
                  },
                  onSend: () {
                    // 1. add the user's message to the chat object
                    final newUserMsg = Message(
                      timeCreated: Timestamp.now(),
                      isMsgUser: true,
                      content: _textController.text,
                    );
                    stateProvider.addToCurrentChat(newUserMsg);

                    // 2. add the user's message Content to the chat content list
                    final newUserContent = Content(
                      role: "user",
                      parts: [
                        Parts(
                          text: _textController.text,
                        ),
                      ],
                    );
                    setState(() => chatContent.add(newUserContent));
                    _textController.clear();
                    loading = true;

                    // 3. send the chat content list to LAILA and update the local content list as the model responds
                    LAILA.gemini.streamChat(chatContent).listen((candidates) {
                      loading = false;
                      setState(() {
                        if (chatContent.isNotEmpty &&
                            chatContent.last.role == candidates.content?.role) {
                          final tempStr =
                              '${chatContent.last.parts!.last.text}${candidates.output}';
                          // if it is, then add the candidates output to the last message
                          chatContent.last.parts!.last.text = tempStr;

                          // also update the last message in the local chat object
                          if (stateProvider.currentChat!.msgs.isNotEmpty) {
                            stateProvider.currentChat!.msgs.last.content =
                                tempStr;
                          }
                          // stateProvider.currentChat!.msgs.last.content = tempStr;
                        } else {
                          final newModelContent = Content(
                            role: "model",
                            parts: [
                              Parts(
                                text: candidates.output,
                              ),
                            ],
                          );
                          chatContent.add(newModelContent);
                          final newModelMsg = Message(
                            timeCreated: Timestamp.now(),
                            isMsgUser: false,
                            content: chatContent.last.parts!.last.text!,
                          );
                          stateProvider.addToCurrentChat(newModelMsg);
                        }
                      });

                      loading = false;
                    })
                      ..onError((error, stackTrace) {
                        try {} catch (_) {}
                      })
                      ..onDone(
                        () => _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceIn,
                        ),
                      );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
