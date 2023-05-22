import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/controllers/review_controller.dart';
import 'package:eventide_organizer_app/models/review_model.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:eventide_organizer_app/screens/main/review/review_item.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
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
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const CustomText(
            "Reviews",
            fontSize: 30,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: ReviewController().getReviews(
                Provider.of<UserProvider>(context, listen: false)
                    .organizerModel!
                    .uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: CustomText(
                    "No reviews yet",
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
                Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                var model = ReviewModel.fromJason(data);

                _reviewsList.add(model);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: const Color.fromARGB(255, 241, 241, 241),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                CustomText(
                                  _reviewsList.isEmpty
                                      ? '0'
                                      : getAvgStarCount(),
                                  fontSize: 40,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                const CustomText(
                                  "/5",
                                  fontSize: 20,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            CustomText(
                              'Based on ${getUserCount()} reviews',
                              fontSize: 14,
                              color: AppColors.primaryAshThree,
                            ),
                            const SizedBox(height: 10),
                            ratingBar(double.parse(getAvgStarCount()))
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                ratingBar(5),
                                const SizedBox(width: 5),
                                CustomText(
                                  "${getFiveStarCount()}",
                                  fontSize: 12,
                                  color: AppColors.primaryAshTwo,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ratingBar(4),
                                const SizedBox(width: 5),
                                CustomText(
                                  '${getFourStarCount()}',
                                  fontSize: 12,
                                  color: AppColors.primaryAshTwo,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ratingBar(3),
                                const SizedBox(width: 5),
                                CustomText(
                                  "${getThreeStarCount()}",
                                  fontSize: 12,
                                  color: AppColors.primaryAshTwo,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ratingBar(2),
                                const SizedBox(width: 5),
                                CustomText(
                                  "${getTwoStarCount()}",
                                  fontSize: 12,
                                  color: AppColors.primaryAshTwo,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ratingBar(1),
                                const SizedBox(width: 5),
                                CustomText(
                                  "${getOneStarCount()}",
                                  fontSize: 12,
                                  color: AppColors.primaryAshTwo,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: CustomText(
                      'User reviews',
                      fontSize: 20,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => UserReviewsItems(
                              reviewModel: _reviewsList[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: _reviewsList.length))
                ],
              );
            }));
  }

  RatingBar ratingBar(double count) {
    return RatingBar.builder(
      initialRating: count,
      minRating: 1,
      itemSize: 20,
      ignoreGestures: true,
      unratedColor: const Color.fromARGB(255, 226, 226, 226),
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
