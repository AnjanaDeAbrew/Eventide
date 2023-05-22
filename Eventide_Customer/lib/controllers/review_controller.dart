import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/models/review_model.dart';
import 'package:eventide_app/models/user_model.dart';
import 'package:eventide_app/utils/alert_helper.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ReviewController {
  //--------============================saving user data in cloud firestore======================
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference reviews =
      FirebaseFirestore.instance.collection('reviews');

  Future<void> saveReview(
      UserModel user,
      OrganizerModel organizer,
      int starCount,
      String reviewComment,
      String reviewId,
      BuildContext context) async {
    await reviews.add({
      'reviewId': reviewId,
      'user': user.toJson(),
      'organizer': organizer.toJson(),
      'starCount': starCount,
      'reviewComment': reviewComment,
    }).then((DocumentReference doc) {
      return reviews.doc(doc.id).update({'reviewId': doc.id});
    }).then((value) {
      AlertHelper.showSnackBar(context, "Okey, Your review has posted !!!",
          AnimatedSnackBarType.success);
      UtilFunction.goBack(context);
    }).catchError((error) => Logger().e("Failed to add booking: $error"));
  }

  Stream<QuerySnapshot> getReviews(String orgUid) =>
      reviews.where("organizer.uid", isEqualTo: orgUid).snapshots();

  //---fetch review list from cloudfirestore

  Future<List<ReviewModel>> fetchReviewList(String orgUid) async {
    try {
      //----------------firebase query that find by user id and fetch booking collection
      var querySnapshot =
          await reviews.where("organizer.uid", isEqualTo: orgUid).get();
      Logger().i(querySnapshot.docs.length);

      //temp organizer list
      List<ReviewModel> list = [];

      for (var e in querySnapshot.docs) {
        //------------mapping product data into organizer model
        ReviewModel model =
            ReviewModel.fromJason(e.data() as Map<String, dynamic>);

        //---adding to the product list
        list.add(model);
      }

      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
