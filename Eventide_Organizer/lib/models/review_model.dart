import 'package:eventide_organizer_app/models/organizer_model.dart';
import 'package:eventide_organizer_app/models/user_model.dart';

class ReviewModel {
  String reviewId;
  UserModel user;
  OrganizerModel organizer;
  int starCount;
  String reviewComment;

  ReviewModel(
    this.reviewId,
    this.user,
    this.organizer,
    this.starCount,
    this.reviewComment,
  );

  ReviewModel.fromJason(Map<String, dynamic> json)
      : reviewId = json['reviewId'],
        user = UserModel.fromJason(json['user'] as Map<String, dynamic>),
        organizer =
            OrganizerModel.fromJason(json['organizer'] as Map<String, dynamic>),
        starCount = (json['starCount'] as num).toInt(),
        reviewComment = json['reviewComment'];
}
