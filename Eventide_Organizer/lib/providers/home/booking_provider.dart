import 'package:eventide_organizer_app/controllers/booking_controller.dart';
import 'package:eventide_organizer_app/models/booking_model.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class BookingProvider extends ChangeNotifier {
  final BookingController _bookingController = BookingController();
  //---------store organizer list
  List<BookingModel> _bookings = [];

  List<BookingModel> get bookings => _bookings;

  //---start fetch bookings
  Future<void> startFetchBookings(BuildContext context) async {
    try {
      _bookings = await _bookingController.fetchBookingList(
          Provider.of<UserProvider>(context, listen: false)
              .organizerModel!
              .uid);
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  //---start update status
  Future<void> startupdateStatus(String docId, String status, int index) async {
    try {
      String newStatus = await _bookingController.updateStatus(docId, status);
      _bookings[index].status = newStatus;
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  //---start update status
  Future<void> startupdateDateTime(
      String docId, String dateTime, int index) async {
    try {
      String newDateTime =
          await _bookingController.updateDateTime(docId, dateTime);
      _bookings[index].dateTime = newDateTime;
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  //---start update status
  Future<void> startupdateNotify(String docId, String notify) async {
    try {
      await _bookingController.updateNotify(docId, notify);

      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }
}
