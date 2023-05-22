import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventide_organizer_app/controllers/auth_controller.dart';
import 'package:eventide_organizer_app/models/organizer_model.dart';
import 'package:eventide_organizer_app/screens/auth/login_page.dart';
import 'package:eventide_organizer_app/screens/home/home_page.dart';
import 'package:eventide_organizer_app/utils/alert_helper.dart';
import 'package:eventide_organizer_app/utils/util_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

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
        await startFetchOrganizerData(user.uid, context).then((value) {
          ///-updating onile status
          updateUserOnline(true);
          UtilFunction.navigateTo(context, const HomePage());
        });
      }
    });
  }

  //------------start fetching user data
//--------store fetched user model
//----so that any ui can access this user model as want
  OrganizerModel? _organizerModel;

  OrganizerModel? get organizerModel => _organizerModel;

  Future<void> startFetchOrganizerData(String uid, BuildContext context) async {
    try {
      await _authController.fetchOrganizerData(uid, context).then((value) {
        //----check if fetched result is not null
        if (value != null) {
          _organizerModel = value;
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

  Future<void> selectAndUploadProfileImage() async {
    try {
      _image = (await UtilFunction.pickImageFromGallery())!;

      if (_image.path != "") {
        //----start the loader
        setLoader = true;
        String imgUrl = await _authController.uploadAndUpdatePickedImage(
            _image, _organizerModel!.uid);
        if (imgUrl != "") {
          _organizerModel!.img = imgUrl;
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

  //===========================update details
//---description controler
  final _updateDescription = TextEditingController();

  //--- get description controller
  TextEditingController get updateDescription => _updateDescription;
//---Town controler
  final _updateAddress = TextEditingController();

  //--- get Town controller
  TextEditingController get updateAddress => _updateAddress;

  //---Price controler
  final _updatePrice = TextEditingController();

  //--- get Price controller
  TextEditingController get updatePrice => _updatePrice;

  String _initCode = '+94';
  String get initCode => _initCode;
  set setInitCode(String value) {
    _initCode = value;
    notifyListeners();
  }

//-start saving organizer data
  Future<void> startEditDetails(String uid, BuildContext context) async {
    try {
      if (_updateDescription.text.isNotEmpty &&
          _updateAddress.text.isNotEmpty &&
          _initCode.isNotEmpty &&
          _updatePrice.text.isNotEmpty) {
        AlertHelper.showAlert(context, "Update Success",
            "Details Updated Success", DialogType.success);
      } else {
        AlertHelper.showAlert(context, "Validation error",
            "Fill at least one field", DialogType.error);
      }
      if (_updateDescription.text.isNotEmpty) {
        String desc = await AuthController()
            .updateDescription(uid, _updateDescription.text);
        organizerModel!.description = desc;
        notifyListeners();
      } else {
        organizerModel!.description = organizerModel!.description;
      }

      if (_updateAddress.text.isNotEmpty) {
        String adr =
            await AuthController().updateAddress(uid, _updateAddress.text);
        organizerModel!.address = adr;
        notifyListeners();
      } else {
        organizerModel!.address = organizerModel!.address;
      }

      if (_initCode.isNotEmpty) {
        String mob = await AuthController().updateMobile(uid, _initCode);
        organizerModel!.mobile = mob;
        notifyListeners();
      } else {
        organizerModel!.mobile = organizerModel!.mobile;
      }

      if (_updatePrice.text.isNotEmpty) {
        String pri = await AuthController().updatePrice(uid, _updatePrice.text);
        notifyListeners();
        organizerModel!.price = pri;
      } else {
        organizerModel!.price = organizerModel!.price;
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> logout() async {
    try {
      _authController.updateOnlineStatus(organizerModel!.uid, false);
      await _authController.signOutOrganizer();
    } catch (e) {
      Logger().e(e);
    }
  }

  void updateUserOnline(bool val) {
    try {
      _authController.updateOnlineStatus(organizerModel!.uid, val);
    } catch (e) {
      Logger().e(e);
    }
  }
}
