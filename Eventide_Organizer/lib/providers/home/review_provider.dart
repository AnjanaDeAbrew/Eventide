import 'package:eventide_organizer_app/controllers/review_controller.dart';
import 'package:flutter/material.dart';

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
}
