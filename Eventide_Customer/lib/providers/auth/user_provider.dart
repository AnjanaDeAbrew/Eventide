import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventide_app/controllers/auth_controller.dart';
import 'package:eventide_app/models/user_model.dart';
import 'package:eventide_app/providers/home/booking_provider.dart';
import 'package:eventide_app/providers/organizer/fav_provider.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/screens/auth/login_page.dart';
import 'package:eventide_app/screens/main/main_screen.dart';
import 'package:eventide_app/utils/alert_helper.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  final AuthController _authController = AuthController();

//------initialize the user and listen to the auth state
  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        //------------If the user objecct is null ---- that means the user is signed out or not exists
        //------------so send to the signup
        Logger().i("User is currently signed out!");

        UtilFunction.navigateTo(context, const LoginPage());
      } else {
        //------------If the user objecct is not null ---- that means the auth state is logged in
        //------------so redirect the user to home
        Logger().i("User is signed in!");

        await startFetchUserData(user.uid, context).then((value) {
          //---------start fetch organizers before going to home
          Provider.of<OrganizerProvider>(context, listen: false)
              .startFetchOrganizers();
          Provider.of<FavProvider>(context, listen: false)
              .startFetchFavs(user.uid, context);
          Provider.of<BookingProvider>(context, listen: false)
              .startFetchBookings(context);

          UtilFunction.navigateTo(context, const MainScreen());
        });
      }
    });
  }

  //------------start fetching user data
//--------store fetched user model
//----so that any ui can access this user model as want
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  Future<void> startFetchUserData(String uid, BuildContext context) async {
    try {
      await _authController.fetchUserData(uid).then((value) {
        //----check if fetched result is not null
        if (value != null) {
          _userModel = value;
          notifyListeners();
        } else {
          //--show an error
          AlertHelper.showAlert(context, "Error",
              "Error while fetching user data", DialogType.error);
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //===============================upload and update user image
//------image picker class object
  final ImagePicker _picker = ImagePicker();

//------product image object
  File _image = File("");

  //----get picked file
  File get image => _image;
  //----loading state
  bool _isLoading = false;

  //get loader state
  bool get isLoading => _isLoading;

  //-----set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

//---------------method to profile image
  Future<void> selectAndUploadProfileImage() async {
    try {
      _image = (await UtilFunction.pickImageFromGallery())!;

      if (_image.path != "") {
        //----start the loader
        setLoader = true;
        String imgUrl = await _authController.uploadAndUpdatePickedImage(
            _image, _userModel!.uid);
        if (imgUrl != "") {
          _userModel!.img = imgUrl;
          notifyListeners();

          //----stop the loader
          setLoader = false;
        }
        //----stop the loader
        setLoader = false;
      }
    } catch (e) {
      Logger().e(e);
      //----stop the loader
      setLoader = false;
    }
  }

//---------------method to cover image
  Future<void> selectAndUploadCoverImage() async {
    try {
      _image = (await UtilFunction.pickImageFromGallery())!;

      if (_image.path != "") {
        //----start the loader
        setLoader = true;
        String imgUrl = await _authController.uploadAndUpdatePickedCoverImage(
            _image, _userModel!.uid);
        if (imgUrl != "") {
          _userModel!.coverImg = imgUrl;
          notifyListeners();

          //----stop the loader
          setLoader = false;
        }
        //----stop the loader
        setLoader = false;
      }
    } catch (e) {
      Logger().e(e);
      //----stop the loader
      setLoader = false;
    }
  }
}
