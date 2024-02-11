import 'package:flutter/material.dart';

class ChatInputGroup extends StatelessWidget {
  const ChatInputGroup({
    super.key,
    this.onSend,
    this.onSave,
    required this.textController,
  });

  final VoidCallback? onSend;
  final VoidCallback? onSave;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 55,
              minHeight: 55,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onSave ?? () {},
                    icon: const Icon(Icons.save),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(10),
                      ),
                      iconColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        controller: textController,
                        textAlign: TextAlign.start,
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.black,
                                ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onSend ?? () {},
                    icon: const Icon(Icons.send),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(10),
                      ),
                      iconColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
