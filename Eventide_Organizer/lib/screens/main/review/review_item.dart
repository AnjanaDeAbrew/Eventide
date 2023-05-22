import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/models/review_model.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserReviewsItems extends StatelessWidget {
  const UserReviewsItems({
    super.key,
    required this.reviewModel,
  });
  final ReviewModel reviewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(10),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color.fromARGB(255, 228, 244, 248).withOpacity(.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(reviewModel.user.img),
              ),
              const SizedBox(width: 20),
              CustomText(
                reviewModel.user.name,
                fontSize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              const Spacer(),
              ratingBar(reviewModel.starCount.toDouble()),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              child: CustomText(
                reviewModel.reviewComment,
                fontSize: 14,
                color: AppColors.black,
                textAlign: TextAlign.left,
              ),
            ),
          )
        ],
      ),
    );
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
