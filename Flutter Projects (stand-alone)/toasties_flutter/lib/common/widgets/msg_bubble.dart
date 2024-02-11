import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:toasties_flutter/common/entity/message.dart';

class ToastieChatBubble extends StatelessWidget {
  const ToastieChatBubble({
    super.key,
    required this.isMsgUser,
    required this.child,
  });

  final bool isMsgUser;
  final Widget child;

  final _bubbleVerticalGap = 6.0;

  @override
  Widget build(BuildContext context) {
    return isMsgUser
        // return message.isMsgUser
        ? _buildUserChatBubble(context)
        : _buildAIChatBubble(context);
  }

  ChatBubble _buildAIChatBubble(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        left: 10,
        right: 80,
        top: _bubbleVerticalGap,
        bottom: _bubbleVerticalGap,
      ),
      padding: const EdgeInsets.all(15),
      elevation: 4,
      shadowColor:
          Theme.of(context).colorScheme.background.computeLuminance() > 0.5
              ? Colors.black
              : Theme.of(context).colorScheme.primary,
      child: _buildChild(context),
    );
  }

  ChatBubble _buildUserChatBubble(BuildContext context) {
    return ChatBubble(
        clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(
          left: 80,
          right: 10,
          top: _bubbleVerticalGap,
          bottom: _bubbleVerticalGap,
        ),
        padding: const EdgeInsets.all(15),
        backGroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        child: _buildChild(context));
  }

  Widget _buildChild(BuildContext context) {
    if (child is Text) {
      return child;
    } else if (child is Markdown) {
      return child;
    }

    return const Text("❌❌ CHILD WIDGET ERROR ❌❌");
  }

  factory ToastieChatBubble.fromContent(Content content) {
    return ToastieChatBubble(
      isMsgUser: content.role == 'user',
      child: content.role == 'user'
          ? Text(
              content.parts?.lastOrNull?.text ?? "❌❌ ERROR ❌❌",
              style: TextStyle(
                color: content.role == 'user' ? Colors.black : Colors.white,
              ),
            )
          : Markdown(
              data: content.parts?.lastOrNull?.text ?? "❌❌ ERROR ❌❌",
              selectable: true,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              listItemCrossAxisAlignment:
                  MarkdownListItemCrossAxisAlignment.start,
              physics: const NeverScrollableScrollPhysics(),
              softLineBreak: true,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  color: content.role == 'user' ? Colors.black : Colors.white,
                ),
              ),
            ),
    );
  }
}
