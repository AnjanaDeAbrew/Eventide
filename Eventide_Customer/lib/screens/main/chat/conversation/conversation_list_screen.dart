import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/chat_controller.dart';
import 'package:eventide_app/models/conversation_model.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/providers/home/chat_provider.dart';
import 'package:eventide_app/screens/main/chat/chats/chat_screen.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});
  final List<ConversationModel> _conversations = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: ChatController().getConversations(value.userModel!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: CustomText(
                    "No conversations, error occured",
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
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: CustomText(
                    "No conversations",
                    fontSize: 20,
                    color: AppColors.primaryAshTwo,
                  ),
                );
              }

              _conversations.clear();

              for (var e in snapshot.data!.docs) {
                Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                var model = ConversationModel.fromJason(data);

                _conversations.add(model);
              }
              return ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Provider.of<ChatProvider>(context, listen: false)
                              .setConversation(_conversations[index]);
                          UtilFunction.navigateTo(context,
                              ChatScreen(conId: _conversations[index].id));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: AppColors.primaryAshOne,
                              offset: Offset(0, 7),
                            )
                          ], color: AppColors.white),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          height: 85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<UserProvider>(
                                builder: (context, value, child) {
                                  OrganizerModel model =
                                      OrganizerModel.fromJason(
                                          _conversations[index].usersArray[1]);

                                  return Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(model.img),
                                        radius: 26,
                                      ),
                                      const SizedBox(width: 15),
                                      SizedBox(
                                        width: 280,
                                        // color: AppColors.red,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              model.name,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              fontSize: 16,
                                              color: AppColors.black,
                                            ),
                                            const SizedBox(height: 3),
                                            CustomText(
                                              _conversations[index].lastMessage,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.left,
                                              color: AppColors.primaryAshTwo,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 5),
                                  CustomText(
                                      UtilFunction.getTimeAgo(
                                          _conversations[index]
                                              .lastMessageTime),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryAshThree)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(
                      height: 0,
                      color: AppColors.primaryAshOne,
                      endIndent: 22,
                      indent: 22),
                  itemCount: _conversations.length);
            });
      },
    );
  }
}
