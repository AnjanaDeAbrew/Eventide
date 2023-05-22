import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/organizer_controller.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/providers/home/chat_provider.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CahtOrgListScreen extends StatelessWidget {
  CahtOrgListScreen({super.key});
  final List<OrganizerModel> _organizers = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: OrganizerController().getOrganizers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: CustomText(
                "No Organizers",
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

          _organizers.clear();

          for (var e in snapshot.data!.docs) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            var model = OrganizerModel.fromJason(data);

            _organizers.add(model);
          }
          return ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: AppColors.primaryAshOne,
                        offset: Offset(0, 7),
                      )
                    ], color: AppColors.white),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    height: 85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(_organizers[index].img),
                              radius: 26,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 190,
                                      child: CustomText(
                                        _organizers[index].name,
                                        textOverflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        fontSize: 15,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    if (_organizers[index].isOnline)
                                      const Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: Colors.green,
                                      )
                                  ],
                                ),
                                CustomText(
                                  _organizers[index].isOnline
                                      ? "online"
                                      : UtilFunction.getTimeAgo(
                                          _organizers[index].lastSeen),
                                  textOverflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  textAlign: TextAlign.left,
                                  color: AppColors.primaryAshThree,
                                )
                              ],
                            ),
                          ],
                        ),
                        Consumer<ChatProvider>(
                          builder: (context, value, child) {
                            return ElevatedButton(
                                onPressed: () {
                                  value.startCreateConversation(
                                      context, _organizers[index], index);
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: value.loadingIndex == index
                                        ? Colors.white
                                        : AppColors.primaryColor),
                                child: value.loadingIndex == index
                                    ? const SpinKitWave(
                                        color: AppColors.primaryColor,
                                        size: 10,
                                      )
                                    : const CustomText(
                                        "chat",
                                        fontSize: 15,
                                      ));
                          },
                        )
                      ],
                    ),
                  ),
              separatorBuilder: (context, index) => const Divider(
                  height: 0,
                  color: AppColors.primaryAshOne,
                  endIndent: 22,
                  indent: 22),
              itemCount: _organizers.length);
        });
  }
}
