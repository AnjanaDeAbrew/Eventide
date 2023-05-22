import 'package:eventide_app/controllers/fav_controller.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FavProvider extends ChangeNotifier {
  final FavController _favController = FavController();

  Future<void> startAddFav(
      UserModel user, OrganizerModel organizer, BuildContext context) async {
    try {
      await _favController.saveFav(user, organizer, context);
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> removeFromFav(
      UserModel user, OrganizerModel organizer, BuildContext context) async {
    try {
      await _favController.removeFromFav(user.uid, organizer.uid, context);
    } catch (e) {
      Logger().e(e);
    }
  }

  //---------store review list
  List<OrganizerModel> _favList = [];

  List<OrganizerModel> get favList => _favList;

  //---start fetch review
  Future<void> startFetchFavs(String userId, BuildContext context) async {
    try {
      _favList = await _favController.fetchFavist(userId);
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }
}
