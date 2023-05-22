import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventide_app/controllers/booking_controller.dart';
import 'package:eventide_app/models/booking_model.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/screens/main/success/succes_page.dart';
import 'package:eventide_app/utils/alert_helper.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class BookingProvider extends ChangeNotifier {
  final BookingController _bookingController = BookingController();

  //-----------date controller
  String _selectedDate = '';
//-----get date controller
  String get date => _selectedDate;
  //----set time value
  set setDate(String value) {
    _selectedDate = value;
    notifyListeners();
  }

  //--------------time value
  String _timeValue = '';
//---get time value
  String get timeValue => _timeValue;

//----set time value
  set setTime(String value) {
    _timeValue = value;
    notifyListeners();
  }

  //--------------category value
  int _catValue = 0;
//---get time value
  int get catValue => _catValue;

  //----set category value
  set setCat(int value) {
    _catValue = value;

    notifyListeners();
  }

  String status = 'pending';

  String docId = '';
  String dateTime = '';
  bool check = true;

  //----count text controller
  final _count = TextEditingController();
  //-------get contoller
  TextEditingController get count => _count;

  Future<void> startBooking(
      BuildContext context,
      String uid,
      String userName,
      String userEmail,
      String userMobile,
      String orgUid,
      String orgName,
      String orgEmail,
      String orgMobile) async {
    try {
      if (_timeValue != "" && _count.text.isNotEmpty && _catValue != 0) {
        // if (bookings.isNotEmpty) {
        //   for (int i = 0; i < bookings.length; i++) {
        //     BookingModel bookingModel =
        //         bookings.where((e) => e.orgUid == orgUid).elementAt(i);
        //     if (!bookings.contains(bookingModel)) {
        //       check = true;
        //     } else {
        //       check = false;
        //     }
        //   }
        // }
        // if (check == true) {
        await _bookingController
            .saveBookingDetails(
          uid,
          userName,
          userEmail,
          userMobile,
          orgUid,
          orgName,
          orgEmail,
          orgMobile,
          _selectedDate,
          _timeValue,
          count.text,
          status,
          docId,
          dateTime,
          catValue,
          context,
        )
            .then((value) {
          UtilFunction.navigateTo(context, const Success());
        }).then((value) {
          _catValue = 0;
          count.clear();
        });
        // } else {
        //   //-----shows a error dialog
        //   AlertHelper.showAlert(context, "Input error",
        //       "Cannot Add a Booking on same Category", DialogType.error);
        // }
      } else {
        //-----shows a error dialog
        AlertHelper.showAlertLogin(context, "Validation error",
            "Hey, Submit all details", DialogType.error);
      }
    } catch (e) {
      //-----shows a error dialog
      AlertHelper.showAlertLogin(
          context, "Validation error", "Unknown Error", DialogType.error);
    }
  }

//---------store organizer list
  List<BookingModel> _bookings = [];

  List<BookingModel> get bookings => _bookings;

  //---start fetch products
  Future<void> startFetchBookings(BuildContext context) async {
    try {
      _bookings = await _bookingController.fetchBookingList(
          Provider.of<UserProvider>(context, listen: false).userModel!.uid);
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
  Future<void> startDeleteBooking(String docId) async {
    try {
      await _bookingController.deleteBooking(docId);
    } catch (e) {
      Logger().e(e);
    }
  }
}
