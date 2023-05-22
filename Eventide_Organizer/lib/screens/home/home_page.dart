import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eventide_organizer_app/components/custom_button_update.dart';
import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/controllers/booking_controller.dart';
import 'package:eventide_organizer_app/controllers/review_controller.dart';
import 'package:eventide_organizer_app/models/booking_model.dart';
import 'package:eventide_organizer_app/models/review_model.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:eventide_organizer_app/screens/home/update_details.dart';
import 'package:eventide_organizer_app/screens/main/drawer/drawer.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:eventide_organizer_app/utils/util_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Logger().wtf(state);

    switch (state) {
      case AppLifecycleState.resumed:
        Provider.of<UserProvider>(context, listen: false)
            .updateUserOnline(true);
        break;
      case AppLifecycleState.inactive:
        Provider.of<UserProvider>(context, listen: false)
            .updateUserOnline(false);
        break;
      case AppLifecycleState.paused:
        // Provider.of<OrganizerProvider>(context, listen: false)
        //     .updateUserOnline(true);
        break;
      case AppLifecycleState.detached:
        Provider.of<UserProvider>(context, listen: false)
            .updateUserOnline(false);
        break;
    }
  }

  DateTime backPressedTime = DateTime.now();
  Future<bool> _onBackButtonDoubleClicked(BuildContext context) async {
    final difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();
    if (difference >= const Duration(seconds: 2)) {
      toast(context, "Double tap to exit");
      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }

  void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text,
          fontSize: 12,
          color: AppColors.white,
        ),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        margin: const EdgeInsets.symmetric(horizontal: 100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor:
            const Color.fromARGB(255, 120, 119, 119).withOpacity(.7),
      ),
    );
  }

  int oneStarCount = 0;
  int twoStarCount = 0;
  int threeStarCount = 0;
  int fourStarCount = 0;
  int fiveStarCount = 0;
  String avgRating = '';
  int userCount = 0;
//---------get one star
  int getOneStarCount() {
    oneStarCount = _reviewsList.where((e) => e.starCount == 1).length;
    return oneStarCount;
  }

//---------get two star
  int getTwoStarCount() {
    twoStarCount = _reviewsList.where((e) => e.starCount == 2).length;
    return twoStarCount;
  }

  //---------get three star
  int getThreeStarCount() {
    threeStarCount = _reviewsList.where((e) => e.starCount == 3).length;
    return threeStarCount;
  }

  //---------get four star
  int getFourStarCount() {
    fourStarCount = _reviewsList.where((e) => e.starCount == 4).length;
    return fourStarCount;
  }

  //---------get five star
  int getFiveStarCount() {
    fiveStarCount = _reviewsList.where((e) => e.starCount == 5).length;
    return fiveStarCount;
  }

  //---------get avg star
  String getAvgStarCount() {
    avgRating = ((1 * getOneStarCount() +
                2 * getTwoStarCount() +
                3 * getThreeStarCount() +
                4 * getFourStarCount() +
                5 * getFiveStarCount()) /
            (getOneStarCount() +
                getTwoStarCount() +
                getThreeStarCount() +
                getFourStarCount() +
                getFiveStarCount()))
        .toStringAsFixed(1);

    return avgRating;
  }

  //---------get user count
  int getUserCount() {
    userCount = _reviewsList.length;
    return userCount;
  }

  final List<ReviewModel> _reviewsList = [];

  final List<BookingModel> _bookings = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackButtonDoubleClicked(context),
      child: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: snapshot.data == ConnectivityResult.none
                  ? const Color.fromARGB(255, 212, 211, 211)
                  : AppColors.white,
              body: snapshot.data == ConnectivityResult.none
                  ? CupertinoAlertDialog(
                      title: const CustomText('Oops unable to load',
                          color: AppColors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                      content: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CustomText(
                            "We're having trouble to connecting. Please check your connectivity.",
                            textAlign: TextAlign.left,
                            color: AppColors.primaryAshThree,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      actions: [
                        CupertinoButton(
                          color: AppColors.primaryColor,
                          onPressed: () {},
                          padding: const EdgeInsets.all(10),
                          child: const CustomText('PLEASE TRY AGAIN',
                              textAlign: TextAlign.center,
                              color: AppColors.white,
                              fontSize: 18),
                        )
                      ],
                    )
                  : Consumer<UserProvider>(
                      builder: (context, value, child) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: BookingController()
                                .getBookings(value.organizerModel!.uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: CustomText(
                                      "No detils to show, error occured"),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              Logger().i(snapshot.data!.docs.length);
                              _bookings.clear();

                              for (var e in snapshot.data!.docs) {
                                Map<String, dynamic> data =
                                    e.data() as Map<String, dynamic>;
                                var model = BookingModel.fromJason(data);

                                _bookings.add(model);
                              }
                              return SafeArea(
                                child: SingleChildScrollView(
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: ReviewController().getReviews(
                                            value.organizerModel!.uid),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return const Center(
                                              child: CustomText(
                                                "No reviews",
                                                fontSize: 20,
                                                color: AppColors.primaryAshTwo,
                                              ),
                                            );
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          Logger()
                                              .w(snapshot.data!.docs.length);
                                          _reviewsList.clear();

                                          for (var e in snapshot.data!.docs) {
                                            Map<String, dynamic> data = e.data()
                                                as Map<String, dynamic>;
                                            var model =
                                                ReviewModel.fromJason(data);

                                            _reviewsList.add(model);
                                          }
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, left: 20),
                                                child: Row(
                                                  children: [
                                                    Builder(builder: (context) {
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () {
                                                          Scaffold.of(context)
                                                              .openDrawer();
                                                        },
                                                        child: badges.Badge(
                                                          position: badges
                                                                  .BadgePosition
                                                              .topEnd(
                                                                  top: 3,
                                                                  end: -2),
                                                          badgeStyle: badges.BadgeStyle(
                                                              elevation: 0,
                                                              badgeColor: _bookings
                                                                      .where((e) =>
                                                                          e.status ==
                                                                          'pending')
                                                                      .isNotEmpty
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .transparent),
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(value
                                                                    .organizerModel!
                                                                    .img),
                                                            radius: 30,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                    const SizedBox(width: 20),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const CustomText(
                                                            "Welcome",
                                                            color: AppColors
                                                                .primaryAshTwo,
                                                            fontSize: 15),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.75,
                                                          child: CustomText(
                                                            value.organizerModel !=
                                                                    null
                                                                ? value
                                                                    .organizerModel!
                                                                    .name
                                                                : "",
                                                            color:
                                                                AppColors.black,
                                                            textAlign:
                                                                TextAlign.left,
                                                            fontSize: 22,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              InkWell(
                                                onTap: () {
                                                  value
                                                      .selectAndUploadProfileImage();
                                                },
                                                child: value.isLoading
                                                    ? const CircularProgressIndicator
                                                        .adaptive()
                                                    : Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 15,
                                                            vertical: 40),
                                                        height: 470,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppColors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                blurRadius: 8,
                                                                offset: Offset(
                                                                    2, 9),
                                                                color: AppColors
                                                                    .primaryAshThree)
                                                          ],
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  value
                                                                      .organizerModel!
                                                                      .img),
                                                              opacity: .7,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    CustomText(
                                                      _reviewsList.isEmpty
                                                          ? '0'
                                                          : getAvgStarCount(),
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    CustomText(
                                                      '(${getUserCount()} Review)',
                                                      color: AppColors
                                                          .primaryAshTwo,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //---------------------------------Full details of the organizer
                                              const SizedBox(height: 30),

                                              //----------------------------------------Description part

                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24),
                                                child: CustomText(
                                                  "Descrption",
                                                  color: AppColors.black,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24),
                                                child: SizedBox(
                                                  width: size.width,
                                                  child: CustomText(
                                                    value.organizerModel != null
                                                        ? value.organizerModel!
                                                            .description
                                                        : "",
                                                    color: AppColors
                                                        .primaryAshThree,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 30),

                                              //-------------------------------------------------------Details part
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24),
                                                child: CustomText(
                                                  "Details",
                                                  color: AppColors.black,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.email_outlined,
                                                        color: Color.fromARGB(
                                                            255, 61, 199, 130)),
                                                    const SizedBox(width: 20),
                                                    CustomText(
                                                      value.organizerModel!
                                                          .email,
                                                      color: AppColors
                                                          .primaryAshThree,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Color.fromARGB(
                                                            255, 231, 176, 57)),
                                                    const SizedBox(width: 20),
                                                    SizedBox(
                                                      width: size.width * 0.70,
                                                      child: CustomText(
                                                        // "value.organizerModel.description",
                                                        value.organizerModel !=
                                                                null
                                                            ? value
                                                                .organizerModel!
                                                                .address
                                                            : "",
                                                        color: AppColors
                                                            .primaryAshThree,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24),
                                                child: InkWell(
                                                  onTap: () {
                                                    // launchUrl(Uri.parse(
                                                    //   'tel:${value.organizerModel.mobile}',
                                                    // ));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.phone_outlined,
                                                          color: Color.fromARGB(
                                                              255,
                                                              254,
                                                              67,
                                                              24)),
                                                      const SizedBox(width: 20),
                                                      CustomText(
                                                        value.organizerModel !=
                                                                null
                                                            ? value
                                                                .organizerModel!
                                                                .mobile
                                                            : "",
                                                        color: AppColors
                                                            .primaryAshThree,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .attach_money_rounded,
                                                        color: Color.fromARGB(
                                                            255, 80, 151, 232)),
                                                    const SizedBox(width: 20),
                                                    CustomText(
                                                      value.organizerModel !=
                                                              null
                                                          ? 'Rs.${value.organizerModel!.price}.00'
                                                          : "",
                                                      color: AppColors
                                                          .primaryAshThree,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.justify,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24),
                                                child: InkWell(
                                                  onTap: () {
                                                    launchUrl(Uri.parse(value
                                                        .organizerModel!.web));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons
                                                              .travel_explore_sharp,
                                                          color: AppColors
                                                              .primaryColor),
                                                      const SizedBox(width: 20),
                                                      CustomText(
                                                        value.organizerModel!
                                                            .web,
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 40),
                                              Center(
                                                child: CustomButtonUpdate(
                                                  "Want to  Update Details?",
                                                  onTap: () {
                                                    UtilFunction.navigateTo(
                                                        context,
                                                        const UpdateDetails());
                                                  },
                                                  color: AppColors.bottomColor,
                                                ),
                                              ),
                                              const SizedBox(height: 40),
                                            ],
                                          );
                                        })),
                              );
                            });
                      },
                    ),
              drawer: const CustomDrawer(),
            );
          }),
    );
  }
}
