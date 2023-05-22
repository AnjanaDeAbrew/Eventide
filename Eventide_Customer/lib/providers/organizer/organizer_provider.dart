import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eventide_app/controllers/organizer_controller.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/utils/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class OrganizerProvider extends ChangeNotifier {
  //------Organizer controller object
  final OrganizerController _organizerController = OrganizerController();

  //----loading state
  bool _isLoading = false;

  //get loader state
  bool get isLoading => _isLoading;

  //-----set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //---------store organizer list
  List<OrganizerModel> _organizers = [];
  List<OrganizerModel> get organizers => _organizers;

  //---start fetch products
  Future<void> startFetchOrganizers() async {
    try {
      //-start the loader
      setLoader = true;
      _organizers = await _organizerController.fetchOrganizerList();
      notifyListeners();

      //-stop the loader
      setLoader = false;
    } catch (e) {
      Logger().e(e);
      //-stop the loader
      setLoader = false;
    }
  }

  //-------to store selected
  late OrganizerModel _organizerModel;

  OrganizerModel get organizerModel => _organizerModel;

  //set product model when clicked on the product tile
  set setOrganizer(OrganizerModel model) {
    _organizerModel = model;
    notifyListeners();
  }

  //==================================add to category list

//------------store wedding product list
  final List<OrganizerModel> _weddingList = [];
  List<OrganizerModel> get weddingList => _weddingList;
//------------store wedding product list
  final List<OrganizerModel> _birthdayList = [];
  List<OrganizerModel> get birthdayList => _birthdayList;
  //------------store wedding product list
  final List<OrganizerModel> _engagementList = [];
  List<OrganizerModel> get engagementList => _engagementList;
  //------------store wedding product list
  final List<OrganizerModel> _aniversaryList = [];
  List<OrganizerModel> get aniversaryList => _aniversaryList;
  //------------store wedding product list
  final List<OrganizerModel> _officeList = [];
  List<OrganizerModel> get officeList => _officeList;
  //------------store wedding product list
  final List<OrganizerModel> _exhibitionList = [];
  List<OrganizerModel> get exhibitionList => _exhibitionList;

  void addToCategoryList(List<OrganizerModel> organizer) {
    for (var e in organizer) {
      if (!_weddingList.contains(e) && e.wedding == true) {
        _weddingList.add(e);
        notifyListeners();
      }

      if (!_birthdayList.contains(e) && e.bday == true) {
        _birthdayList.add(e);
        notifyListeners();
      }
      if (!_engagementList.contains(e) && e.engage == true) {
        _engagementList.add(e);
        notifyListeners();
      }
      if (!_aniversaryList.contains(e) && e.aniversary == true) {
        _aniversaryList.add(e);
        notifyListeners();
      }
      if (!_officeList.contains(e) && e.office == true) {
        _officeList.add(e);
        notifyListeners();
      }
      if (!_exhibitionList.contains(e) && e.exhibition == true) {
        _exhibitionList.add(e);
        notifyListeners();
      }
    }
  }

  //==================add product to favourite

  //------------store fav product list
  final List<OrganizerModel> _favOrganizers = [];

  List<OrganizerModel> get favOrganizer => _favOrganizers;

  //add fav
  void addToFav(OrganizerModel model, BuildContext context) {
    if (_favOrganizers.contains(model)) {
      //-----if exists remove that product from the lsit
      _favOrganizers.remove(model);

      // //-----show snack bar
      // AlertHelper.showSnackBar(
      //     context, "Removed from favourite", AnimatedSnackBarType.error);
      notifyListeners();
    } else {
      //-----adding clicked product to the fav
      _favOrganizers.add(model);

      AlertHelper.showSnackBar(
          context, "Added to favourite", AnimatedSnackBarType.success);
      notifyListeners();
    }
  }

  //-----remove from fav
  void removeFromFav(OrganizerModel model, BuildContext context) {
    _favOrganizers.remove(model);

    AlertHelper.showSnackBar(
        context, "Removed from favourite", AnimatedSnackBarType.error);
    notifyListeners();
  }

  // void updateUserOnline(bool val) {
  //   _organizerController.updateOnlineStatus(organizers[0].uid, val);
  // }
}
