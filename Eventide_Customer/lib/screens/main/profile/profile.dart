import 'package:eventide_app/components/custom_button.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/auth_controller.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/screens/main/drawer/drawer.dart';
import 'package:eventide_app/screens/main/profile/show_fullImage_page.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double coverHeight = 200;
    const double profileHeight = 70;
    const top = coverHeight - profileHeight;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 251, 248, 246),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const Image(
                  image: AssetImage("${AssetConstant.iconPath}menuIcon.png"),
                  color: AppColors.white,
                ),
              );
            },
          ),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            buildTop(size, coverHeight, top, profileHeight),
            buildContent()
          ],
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }

//----------show user details
  Container buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomColumnText(),
    );
  }

  Consumer CustomColumnText() {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return Column(
        children: [
          CustomText(
            value.userModel != null ? value.userModel!.name : "",
            color: AppColors.black,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Icon(Icons.email_outlined, size: 30),
              const SizedBox(width: 20),
              CustomText(
                value.userModel != null ? value.userModel!.email : "",
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Divider(color: AppColors.primaryAshTwo, height: 30),
          Row(
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 30,
              ),
              const SizedBox(width: 20),
              CustomText(
                "UID : ${value.userModel != null ? value.userModel!.uid : ""}",
                color: AppColors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Divider(color: AppColors.primaryAshTwo, height: 30),
          Row(
            children: [
              const Icon(Icons.phone_android_outlined, size: 30),
              const SizedBox(width: 20),
              CustomText(
                value.userModel != null ? value.userModel!.mobile : "",
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 150),
          CustomButton(
            "Logout",
            onTap: () {
              AuthController.signOutUser();
            },
          )
        ],
      );
    });
  }

//------------create top part of screen
  Stack buildTop(
      Size size, double coverHeight, double top, double profileHeight) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 90),
          child: customCoverImage(size, coverHeight),
        ),
        Positioned(
          top: top,
          child: customProfileImage(profileHeight),
        ),
      ],
    );
  }

//-------------profile picture
  CircleAvatar customProfileImage(double profileHeight) {
    final size = MediaQuery.of(context).size;
    return CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: 75,
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            return InkWell(
              onTap: () {
                showModelBottomProfile('Profile', value.userModel!.img);
              },
              child: CircleAvatar(
                radius: profileHeight,
                backgroundImage: NetworkImage(value.userModel!.img),
              ),
            );
          },
        ));
  }

//------------cover image
  Container customCoverImage(Size size, double coverHeight) {
    return Container(
        decoration: const BoxDecoration(
            // border: Border.all(width: 1, color: AppColors.black),
            boxShadow: [
              BoxShadow(blurRadius: 0, offset: Offset(0, 0)),
              BoxShadow(
                offset: Offset(-1, 15),
                blurRadius: 20,
              ),
            ]),
        width: size.width,
        height: coverHeight,
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            return InkWell(
              onTap: () {
                showModelBottomCover('Cover', value.userModel!.coverImg);
              },
              child: Hero(
                tag: "imageHero",
                child: Image.network(
                  value.userModel!.coverImg,
                  color: AppColors.black.withOpacity(.3),
                  colorBlendMode: BlendMode.darken,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ));
  }

  //----------------show bottom pannel to view or change profile image
  void showModelBottomProfile(String type, String image) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              height: 200,
              padding: const EdgeInsets.all(20),
              child: Consumer<UserProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          value.selectAndUploadProfileImage();
                        },
                        child: Row(
                          children: [
                            const CircleAvatar(
                                backgroundColor: AppColors.primaryAshOne,
                                radius: 20,
                                child: Icon(
                                  Icons.photo,
                                  color: AppColors.black,
                                )),
                            const SizedBox(width: 30),
                            CustomText("Choose $type image",
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return DetailScreen(
                              image: value.userModel!.img,
                            );
                          }));
                        },
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.primaryAshOne,
                              radius: 20,
                              child: Hero(
                                  tag: 'hero',
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppColors.black,
                                  )),
                            ),
                            const SizedBox(width: 30),
                            CustomText("View $type image",
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ));
        },
        backgroundColor: Colors.transparent);
  }

  //----------------show bottom pannel to view or change cover image
  void showModelBottomCover(String type, String image) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              height: 200,
              padding: const EdgeInsets.all(20),
              child: Consumer<UserProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          value.selectAndUploadCoverImage();
                        },
                        child: Row(
                          children: [
                            const CircleAvatar(
                                backgroundColor: AppColors.primaryAshOne,
                                radius: 20,
                                child: Icon(
                                  Icons.photo,
                                  color: AppColors.black,
                                )),
                            const SizedBox(width: 30),
                            CustomText("Choose $type image",
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return DetailScreen(
                              image: value.userModel!.coverImg,
                            );
                          }));
                        },
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.primaryAshOne,
                              radius: 20,
                              child: Hero(
                                  tag: 'hero',
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppColors.black,
                                  )),
                            ),
                            const SizedBox(width: 30),
                            CustomText("View $type image",
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ));
        },
        backgroundColor: Colors.transparent);
  }
}
