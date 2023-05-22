import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BookingController {
  //--------============================saving user data in cloud firestore======================
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  String notify = '';

  Future<void> saveBookingDetails(
      String uid,
      String userName,
      String userEmail,
      String userMobile,
      String orgUid,
      String orgName,
      String orgEmail,
      String orgMobile,
      String date,
      String timeValue,
      String count,
      String status,
      String docId,
      String dateTime,
      int catValue,
      BuildContext context) async {
    await bookings.add({
      'uid': uid,
      'userName': userName,
      'userEmail': userEmail,
      'userMobile': userMobile,
      'orgUid': orgUid,
      'orgName': orgName,
      'orgEmail': orgEmail,
      'orgMobile': orgMobile,
      'date': date,
      'timeValue': timeValue,
      'count': count,
      'status': status,
      'docId': docId,
      'dateTime': dateTime,
      'catValue': catValue,
      'notify': notify,
    }).then((DocumentReference doc) {
      return bookings.doc(doc.id).update({'docId': doc.id});
    }).catchError((error) => Logger().e("Failed to add booking: $error"));
  }

  Stream<QuerySnapshot> getBookings(String uid) =>
      bookings.where("uid", isEqualTo: uid).snapshots();
  //---fetch organizer list from cloudfirestore

  Future<List<BookingModel>> fetchBookingList(String uid) async {
    try {
      //----------------firebase query that find by user id and fetch booking collection
      var querySnapshot = await bookings.where("uid", isEqualTo: uid).get();
      Logger().i(querySnapshot.docs.length);

      //temp organizer list
      List<BookingModel> list = [];

      for (var e in querySnapshot.docs) {
        //------------mapping product data into organizer model
        BookingModel model =
            BookingModel.fromJason(e.data() as Map<String, dynamic>);

        //---adding to the product list
        list.add(model);
      }

      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  //----update status data in firestore
  Future<String> updateStatus(
    String docId,
    String status,
  ) async {
    await bookings.doc(docId).update(
      {
        'status': status,
      },
    );
    return status;
  }

  //----delete booking data in firestore
  Future<void> deleteBooking(
    String docId,
  ) async {
    await bookings.doc(docId).delete();
  }

  Future<void> updateNotify(
    String docId,
  ) async {
    await bookings.doc(docId).update(
      {
        'notify': '',
      },
    );
  }
}
