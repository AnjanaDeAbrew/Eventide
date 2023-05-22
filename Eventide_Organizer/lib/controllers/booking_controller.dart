import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_organizer_app/models/booking_model.dart';
import 'package:logger/logger.dart';

class BookingController {
  //--------============================saving user data in cloud firestore======================
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  //---fetch booking list from cloudfirestore

  Stream<QuerySnapshot> getBookings(String uid) =>
      bookings.where("orgUid", isEqualTo: uid).snapshots();

  Future<List<BookingModel>> fetchBookingList(String uid) async {
    try {
      //----------------firebase query that find by organization id and fetch booking collection

      var querySnapshot = await bookings.where("orgUid", isEqualTo: uid).get();
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

  //----update description data in firestore
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

  //----update date and time in firestore
  Future<String> updateDateTime(
    String docId,
    String dateTime,
  ) async {
    await bookings.doc(docId).update(
      {
        'dateTime': dateTime,
      },
    );
    return dateTime;
  }

  //----update notifiy data in firestore
  Future<void> updateNotify(
    String docId,
    String notify,
  ) async {
    await bookings.doc(docId).update(
      {
        'notify': notify,
      },
    );
  }
}
