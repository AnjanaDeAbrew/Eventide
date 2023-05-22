import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/models/message_model.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    this.isSender = true,
    required this.model,
  });

  final bool isSender;

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        BubbleSpecialThree(
          text: model.message,
          color: isSender
              ? const Color.fromARGB(255, 236, 56, 56)
              : const Color.fromARGB(255, 247, 119, 232),
          tail: true,
          isSender: isSender,
          textStyle: TextStyle(
              color: isSender ? Colors.white : AppColors.white, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24, left: 24),
          child: CustomText(
            UtilFunction.getTimeAgo(model.messageTime),
            textOverflow: TextOverflow.ellipsis,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.left,
            color: AppColors.primaryAshThree,
          ),
        )
      ],
    );
  }
}
