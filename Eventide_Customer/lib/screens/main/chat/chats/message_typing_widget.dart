import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:eventide_app/providers/home/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageTypingWidget extends StatelessWidget {
  const MessageTypingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MessageBar(
      onSend: (String msg) {
        // Logger().w(msg);
        if (msg.trim().isNotEmpty) {
          Provider.of<ChatProvider>(context, listen: false)
              .startSendMessage(context, msg);
        }
      },
      messageBarColor: Colors.transparent,
      sendButtonColor: Colors.green,
    );
  }
}
