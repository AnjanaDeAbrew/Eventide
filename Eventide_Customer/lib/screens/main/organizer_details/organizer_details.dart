import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/components/admin_custom_textfield.dart';
import 'package:eventide_app/components/custom_button.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/review_controller.dart';
import 'package:eventide_app/models/review_model.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/providers/organizer/fav_provider.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/providers/organizer/review_provider.dart';
import 'package:eventide_app/screens/main/book/booking_page.dart';
import 'package:eventide_app/screens/main/review/review.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizerDetailsPage extends StatefulWidget {
  const OrganizerDetailsPage({super.key});

  @override
  State<OrganizerDetailsPage> createState() => _OrganizerDetailsPageState();
}

class _OrganizerDetailsPageState extends State<OrganizerDetailsPage> {
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(child: Consumer<OrganizerProvider>(
          builder: (context, value, child) {
            return StreamBuilder<QuerySnapshot>(
                stream: ReviewController().getReviews(value.organizerModel.uid),
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  Logger().w(snapshot.data!.docs.length);
                  _reviewsList.clear();

                  for (var e in snapshot.data!.docs) {
                    Map<String, dynamic> data =
                        e.data() as Map<String, dynamic>;
                    var model = ReviewModel.fromJason(data);

                    _reviewsList.add(model);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //----------------image with details
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 40),
                        height: 570,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 8,
                                offset: Offset(2, 9),
                                color: AppColors.primaryAshThree)
                          ],
                          image: DecorationImage(
                              image: NetworkImage(value.organizerModel.img),
                              opacity: .7,
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 25),
                                const SizedBox(height: 90),

                                //---------------arrow back box
                                InkWell(
                                  onTap: () {
                                    UtilFunction.goBack(context);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 40, sigmaY: 50),
                                        child: Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromARGB(
                                                      255, 90, 107, 134)
                                                  .withOpacity(0.5)),
                                          child: const Icon(
                                            Icons.arrow_back,
                                            color: AppColors.white,
                                          ),
                                        )),
                                  ),
                                ),

                                //------------favourite icon-----------------------------------------------
                                const Spacer(),

                                Consumer<FavProvider>(
                                  builder: (context, fvalue, child) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 40, sigmaY: 50),
                                          child: Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: const Color.fromARGB(
                                                        255, 90, 107, 134)
                                                    .withOpacity(0.5)),
                                            child: IconButton(
                                              onPressed: () {
                                                if (value.organizerModel.fav ==
                                                    'true') {
                                                  fvalue.removeFromFav(
                                                      Provider.of<UserProvider>(
                                                              context,
                                                              listen: false)
                                                          .userModel!,
                                                      value.organizerModel,
                                                      context);
                                                } else if (value
                                                        .organizerModel.fav ==
                                                    'false') {
                                                  fvalue.startAddFav(
                                                      Provider.of<UserProvider>(
                                                              context,
                                                              listen: false)
                                                          .userModel!,
                                                      value.organizerModel,
                                                      context);
                                                }
                                              },
                                              icon: value.organizerModel.fav ==
                                                      'true'
                                                  ? Image.asset(AssetConstant
                                                      .heartFillPath)
                                                  : Image.asset(
                                                      AssetConstant.hpth,
                                                      width: 25,
                                                      height: 25,
                                                      color: AppColors.white),
                                            ),
                                          )),
                                    );
                                  },
                                ),

                                const SizedBox(width: 25),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    value.organizerModel.name,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontSize: 20,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: AppColors.white,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: size.width * 0.8,
                                        child: CustomText(
                                          value.organizerModel.address,
                                          fontSize: 14,
                                          textAlign: TextAlign.left,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              _reviewsList.isEmpty ? '0' : getAvgStarCount(),
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(width: 10),
                            CustomText(
                              '(${getUserCount()} Review)',
                              color: AppColors.primaryAshTwo,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),

                      //---------------------------------details of organizer-------------------------------
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: CustomText(
                          "Descrption",
                          color: AppColors.black,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: CustomText(
                          value.organizerModel.description,
                          color: AppColors.primaryAshThree,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: CustomText(
                          "Details",
                          color: AppColors.black,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                                'mailto:${value.organizerModel.email}'));
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.email,
                                  color: Color.fromARGB(255, 61, 199, 130)),
                              const SizedBox(width: 20),
                              CustomText(
                                value.organizerModel.email,
                                color: AppColors.primaryAshThree,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_rounded,
                                color: Color.fromARGB(255, 231, 176, 57)),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: size.width * 0.8,
                              child: CustomText(
                                value.organizerModel.address,
                                color: AppColors.primaryAshThree,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                              'tel:${value.organizerModel.mobile}',
                            ));
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.phone,
                                  color: Color.fromARGB(255, 254, 67, 24)),
                              const SizedBox(width: 20),
                              CustomText(
                                value.organizerModel.mobile,
                                color: AppColors.primaryAshThree,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            const Icon(Icons.attach_money,
                                color: Color.fromARGB(255, 80, 151, 232)),
                            const SizedBox(width: 20),
                            CustomText(
                              'Rs. ${value.organizerModel.price}.00',
                              color: AppColors.primaryAshThree,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(value.organizerModel.web));
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.travel_explore_sharp,
                                  color: Color.fromARGB(255, 177, 31, 206)),
                              const SizedBox(width: 20),
                              SizedBox(
                                width: 360,
                                child: CustomText(
                                  value.organizerModel.web,
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.left,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            "Book Now",
                            color: AppColors.bottomColor,
                            height: 65,
                            width: 250,
                            onTap: () {
                              UtilFunction.navigateTo(
                                  context, const BookingPage());
                            },
                          ),
                          InkWell(
                            onTap: () {
                              openDialog(
                                  value.organizerModel.name,
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .userModel!
                                      .name);
                            },
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.primaryAshTwo)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.edit,
                                    color: AppColors.black,
                                    size: 20,
                                  ),
                                  CustomText(
                                    'Write a review',
                                    color: AppColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InkWell(
                          onTap: () {
                            UtilFunction.navigateTo(
                                context, const ReviewScreen());
                          },
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 228, 228, 228)),
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 228, 228, 228)),
                            )),
                            child: Row(
                              children: const [
                                Icon(Icons.reviews_outlined),
                                SizedBox(width: 15),
                                CustomText(
                                  "Reviews",
                                  color: AppColors.black,
                                  fontSize: 18,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                });
          },
        )),
      ),
    );
  }

//------------Rating Bar---------------------------------------------------------------------------------
  Consumer ratingBar() {
    return Consumer<ReviewProvider>(
      builder: (context, value, child) {
        return RatingBar(
          glow: false,
          itemSize: 26,
          initialRating: 0,
          direction: Axis.horizontal,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: const Icon(Icons.star, color: Colors.amber),
            half: const Icon(Icons.star_half, color: Colors.amber),
            empty: const Icon(
              Icons.star_outline,
              color: Color.fromARGB(255, 211, 211, 211),
            ),
          ),
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          onRatingUpdate: (ratingV) {
            setState(() {
              value.setStarCount = ratingV.toInt();
            });
          },
        );
      },
    );
  }

//-------------------------Alert Dialog Box------------------------------------------------------------
  Future openDialog(String orgName, String userName) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: CustomText(
            orgName,
            color: AppColors.primaryAshThree,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          content: SizedBox(
            width: 500,
            height: 260,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          Provider.of<UserProvider>(context, listen: false)
                              .userModel!
                              .img),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          userName,
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        const CustomText(
                          "Posting publicly !",
                          color: AppColors.primaryAshTwo,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ratingBar(),
                const SizedBox(height: 30),
                AdminCustomTextfield(
                  controller:
                      Provider.of<ReviewProvider>(context, listen: false)
                          .reviewComment,
                  hintText:
                      'Share details of your own expirience at this place',
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        UtilFunction.goBack(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1, color: AppColors.primaryAshTwo)),
                        width: 90,
                        height: 40,
                        child: const Center(
                          child: CustomText(
                            'Cancel',
                            color: AppColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Provider.of<ReviewProvider>(context, listen: false)
                            .startAddReview(
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .userModel!,
                                Provider.of<OrganizerProvider>(context,
                                        listen: false)
                                    .organizerModel,
                                context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 90,
                        height: 40,
                        child: const Center(
                          child: CustomText(
                            'Post',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
