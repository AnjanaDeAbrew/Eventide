import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewController {
  //--------============================saving user data in cloud firestore======================
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference reviews =
      FirebaseFirestore.instance.collection('reviews');

  Stream<QuerySnapshot> getReviews(String orgUid) =>
      reviews.where("organizer.uid", isEqualTo: orgUid).snapshots();
}
