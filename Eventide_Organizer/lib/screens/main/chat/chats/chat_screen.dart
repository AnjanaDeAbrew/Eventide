import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/controllers/chat_controller.dart';
import 'package:eventide_organizer_app/models/message_model.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:eventide_organizer_app/screens/main/chat/chats/chat_bubble.dart';
import 'package:eventide_organizer_app/screens/main/chat/chats/header.dart';
import 'package:eventide_organizer_app/screens/main/chat/chats/message_typing_widget.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.conId,
  });

  final String conId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<MessageModel> _messages = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
          stream: ChatController().getMessages(widget.conId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: CustomText(
                  "No messages, error occured",
                  fontSize: 20,
                  color: AppColors.primaryAshTwo,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            _messages.clear();

            for (var e in snapshot.data!.docs) {
              Map<String, dynamic> data = e.data() as Map<String, dynamic>;
              var model = MessageModel.fromJason(data);

              _messages.add(model);
            }

            return Scaffold(
              body: Column(
                children: [
                  const HeaderWidget(),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Consumer<UserProvider>(
                        builder: (context, value, child) {
                          return ChatBubble(
                            isSender: _messages[index].senderId ==
                                value.organizerModel!.uid,
                            model: _messages[index],
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: _messages.length,
                  )),
                  const MessageTypingWidget(),
                ],
              ),
            );
          }),
    );
  }
}
