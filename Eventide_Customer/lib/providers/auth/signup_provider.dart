import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventide_app/controllers/auth_controller.dart';
import 'package:eventide_app/utils/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SignupProvider extends ChangeNotifier {
  //---email controler
  final _email = TextEditingController();

  //--- get email controller
  TextEditingController get emailController => _email;

  //---name controller
  final _name = TextEditingController();

//--- get name controller
  TextEditingController get nameController => _name;

  //----password controller
  final _password = TextEditingController();

  //--- get password controller
  TextEditingController get passwordController => _password;

  //----mobile controller
  final _mobile = TextEditingController();

  //--- get password controller
  TextEditingController get mobileController => _mobile;

  //----loading state
  bool _isLoading = false;

  //get loader state
  bool get isLoading => _isLoading;

  //-----set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

//----------signup fuction
  Future<void> startSignup(BuildContext context) async {
    try {
      if (_email.text.isNotEmpty &&
          _password.text.isNotEmpty &&
          _name.text.isNotEmpty &&
          _mobile.text.isNotEmpty) {
        //---start the loader
        setLoader = true;

        //----start creating the user account
        await AuthController().signupUser(
            _email.text, _password.text, _name.text, _mobile.text, context);

        //----stop the loader
        setLoader = false;
      } else {
        //-----shows a error dialog
        AlertHelper.showAlert(context, "Validation error",
            "Fill all the fields", DialogType.error);
      }
    } catch (e) {
      Logger().e(e);
      //----stop the loader
      setLoader = false;
    }
  }
}
