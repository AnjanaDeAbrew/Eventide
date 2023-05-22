import 'package:eventide_app/components/custom_button.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/auth_controller.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/screens/main/booking/main_booking_page.dart';
import 'package:eventide_app/screens/main/chat/main_chat_page.dart';
import 'package:eventide_app/screens/main/favourite/favourite_page.dart';
import 'package:eventide_app/screens/main/profile/profile.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 350,
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            return Material(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(value.userModel!.coverImg),
                          fit: BoxFit.cover),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 20,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(value.userModel!.img),
                        radius: 34,
                      ),
                    ),
                    accountName:
                        CustomText(value.userModel!.name, fontSize: 22),
                    accountEmail: CustomText(value.userModel!.email,
                        fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                  CustomContainer('Account',
                      icon: Icons.account_circle_rounded,
                      widget: const Profile()),
                  CustomContainer('Favourites',
                      icon: Icons.favorite_outlined, widget: const Favourite()),
                  CustomContainer('Chat',
                      icon: Icons.chat, widget: const MainChatScreen()),
                  CustomContainer('Bookings',
                      icon: Icons.book, widget: const MainBookingPage()),
                  const SizedBox(height: 100),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      "Logout",
                      // color: AppColors.primaryColor,
                      color: const Color(0xff2b2333),
                      height: 55,
                      onTap: () {
                        AuthController.signOutUser();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

//----------------custom container for one item of list view
  InkWell CustomContainer(
    String text, {
    required IconData icon,
    required Widget widget,
    // Future<void>? function,
  }) {
    return InkWell(
      onTap: () {
        // function;
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
            CustomText(
              text,
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.left,
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
