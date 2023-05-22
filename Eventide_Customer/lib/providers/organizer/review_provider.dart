import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventide_app/controllers/review_controller.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/models/review_model.dart';
import 'package:eventide_app/models/user_model.dart';
import 'package:eventide_app/utils/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ReviewProvider extends ChangeNotifier {
  final ReviewController _reviewController = ReviewController();

//---initialize text controller
  final _reviewComment = TextEditingController();
  TextEditingController get reviewComment => _reviewComment;

  //-------------------rating value
  int _starCount = 0;

  int get starCount => _starCount;
  set setStarCount(int starValue) {
    _starCount = starValue;
    notifyListeners();
  }

  String reviewId = '';

  Future<void> startAddReview(
      UserModel user, OrganizerModel organizer, BuildContext context) async {
    try {
      if (_reviewComment.text.isNotEmpty && _starCount != 0) {
        await _reviewController
            .saveReview(user, organizer, starCount, _reviewComment.text,
                reviewId, context)
            .then((value) {
          reviewComment.clear();
          _starCount = 0;
        });
      } else {
        AlertHelper.showAlert(
            context,
            "Validation Error",
            "OOps! Please add a review or write something dear",
            DialogType.error);
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //---------store review list
  List<ReviewModel> _reviewList = [];

  List<ReviewModel> get reviewList => _reviewList;

  //---start fetch review
  Future<void> startFetchReviews(String orgUid, BuildContext context) async {
    try {
      _reviewList = await _reviewController.fetchReviewList(orgUid);
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  //---------store review list
  final List<ReviewModel> _reviewsList = [];

  List<ReviewModel> get reviewsList => _reviewsList;

  int oneStarCount = 0;
  int twoStarCount = 0;
  int threeStarCount = 0;
  int fourStarCount = 0;
  int fiveStarCount = 0;
  String avgRating = '';
  int userCount = 0;
//---------get one star
  int getOneStarCount() {
    oneStarCount = reviewsList.where((e) => e.starCount == 1).length;
    return oneStarCount;
  }

//---------get two star
  int getTwoStarCount() {
    twoStarCount = reviewsList.where((e) => e.starCount == 2).length;
    return twoStarCount;
  }

  //---------get three star
  int getThreeStarCount() {
    threeStarCount = reviewsList.where((e) => e.starCount == 3).length;
    return threeStarCount;
  }

  //---------get four star
  int getFourStarCount() {
    fourStarCount = reviewsList.where((e) => e.starCount == 4).length;
    return fourStarCount;
  }

  //---------get five star
  int getFiveStarCount() {
    fiveStarCount = reviewsList.where((e) => e.starCount == 5).length;
    return fiveStarCount;
  }

  //---------get avg star
  String getAvgStarCount() {
    avgRating = ((1 * oneStarCount +
                2 * twoStarCount +
                3 * threeStarCount +
                4 * fourStarCount +
                5 * fiveStarCount) /
            (oneStarCount +
                twoStarCount +
                threeStarCount +
                fourStarCount +
                fiveStarCount))
        .toStringAsFixed(1);

    return avgRating;
  }

  //---------get user count
  int getUserCount() {
    userCount = reviewsList.length;
    return userCount;
  }
}
