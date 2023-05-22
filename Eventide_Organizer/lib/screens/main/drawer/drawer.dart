import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_organizer_app/components/custom_button.dart';
import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/controllers/booking_controller.dart';
import 'package:eventide_organizer_app/models/booking_model.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:eventide_organizer_app/screens/home/home_page.dart';
import 'package:eventide_organizer_app/screens/main/bookings/main_booking_page.dart';
import 'package:eventide_organizer_app/screens/main/chat/main_chat_page.dart';
import 'package:eventide_organizer_app/screens/main/review/review.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:eventide_organizer_app/utils/assets_constant.dart';
import 'package:eventide_organizer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<BookingModel> _bookings = [];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 350,
      child: Consumer<UserProvider>(builder: (context, value, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: BookingController().getBookings(value.organizerModel!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: CustomText("No Bookings yet"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Logger().i(snapshot.data!.docs.length);
              _bookings.clear();

              for (var e in snapshot.data!.docs) {
                Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                var model = BookingModel.fromJason(data);

                _bookings.add(model);
              }
              return Material(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(AssetConstant.coverImage),
                            fit: BoxFit.cover),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 20,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(value.organizerModel!.img),
                          radius: 34,
                        ),
                      ),
                      accountName:
                          CustomText(value.organizerModel!.name, fontSize: 22),
                      accountEmail: CustomText(value.organizerModel!.email,
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                    CustomContainer('Home Page',
                        icon: Icons.home, widget: const HomePage()),
                    badges.Badge(
                      position: badges.BadgePosition.topEnd(top: 7, end: 185),
                      badgeStyle: badges.BadgeStyle(
                          elevation: 0,
                          badgeColor: _bookings
                                  .where((e) => e.status == 'pending')
                                  .isNotEmpty
                              ? Colors.red
                              : Colors.transparent),
                      badgeContent: CustomText(
                        '${_bookings.where((e) => e.status == 'pending').length}',
                        fontSize: 12,
                      ),
                      child: CustomContainer('Bookings',
                          icon: Icons.book, widget: const MainBookingPage()),
                    ),
                    CustomContainer('Chat',
                        icon: Icons.chat, widget: const MainChatScreen()),
                    CustomContainer('Reviews',
                        icon: Icons.reviews, widget: const ReviewScreen()),
                    const SizedBox(height: 100),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Consumer<UserProvider>(
                          builder: (context, value, child) {
                            return CustomButton(
                              "Logout",
                              // color: AppColors.primaryColor,
                              color: const Color(0xff2b2333),
                              height: 55,
                              onTap: () {
                                value.logout();
                              },
                            );
                          },
                        )),
                  ],
                ),
              );
            });
      }),
    );
  }

//----------------custom container for one item of list view
  InkWell CustomContainer(
    String text, {
    required IconData icon,
    required Widget widget,
    Future<void>? function,
  }) {
    return InkWell(
      onTap: () {
        function;
        UtilFunction.navigateTo(context, widget);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        // color: Colors.amber,
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: AppColors.primaryAshThree,
            ),
            const SizedBox(width: 20),
            SizedBox(
              // width: 100,
              child: CustomText(
                text,
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: AppColors.primaryAshThree,
            ),
          ],
        ),
      ),
    );
  }
}
