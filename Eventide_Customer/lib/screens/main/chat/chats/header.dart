import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/organizer_controller.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/providers/home/chat_provider.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 20,
          color: Color.fromARGB(255, 230, 230, 230),
          offset: Offset(0, 7),
        )
      ], color: AppColors.white),
      child: Row(
        children: [
          Consumer<ChatProvider>(
            builder: (context, value, child) {
              OrganizerModel model = OrganizerModel.fromJason(
                  value.conversationModel.usersArray[1]);
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      UtilFunction.goBack(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 15),
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.img),
                    radius: 20,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: CustomText(
                          model.name,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          color: AppColors.black,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: OrganizerController()
                              .getPeerUserStatus(model.uid),
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            OrganizerModel umodel = OrganizerModel.fromJason(
                                snapshot.data!.data() as Map<String, dynamic>);
                            return CustomText(
                              umodel.isOnline ? "online" : '',
                              textOverflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.left,
                              color: AppColors.black,
                            );
                          }),
                    ],
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
