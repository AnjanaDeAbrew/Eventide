import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventide_app/controllers/auth_controller.dart';
import 'package:eventide_app/utils/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginProvider extends ChangeNotifier {
  //---email controler
  final _email = TextEditingController();

  //--- get email controller
  TextEditingController get emailController => _email;

  //----password controller
  final _password = TextEditingController();

  //--- get password controller
  TextEditingController get passwordController => _password;

  //----loading state
  bool _isLoading = false;

  //get loader state
  bool get isLoading => _isLoading;

  //-----set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

//----------login fuction
  Future<void> startSignIn(BuildContext context) async {
    try {
      if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
        //---start the loader
        setLoader = true;

        //----start creating the user account
        await AuthController()
            .loginUser(_email.text, _password.text, context)
            .then((value) {});

        //----stop the loader
        setLoader = false;
      } else {
        //-----shows a error dialog
        AlertHelper.showAlertLogin(context, "Validation error",
            "Fill all the fields", DialogType.error);
      }
    } catch (e) {
      Logger().e(e);
      //----stop the loader
      setLoader = false;
    }
  }

  //---------forgot password function

  //-------email controller
  final _resetEmail = TextEditingController();

//---get email controller
  TextEditingController get resetEmail => _resetEmail;

  Future<void> startSendPasswordResetEmail(BuildContext context) async {
    try {
      if (_resetEmail.text.isNotEmpty) {
        //------start thr loader
        setLoader = true;

        //---start creating the user account
        await AuthController.sendResetPassEmail(_resetEmail.text, context)
            .then((value) {
          AlertHelper.showAlert(context, "Email has been sent",
              "Please check your inbox", DialogType.success);
        });

        //--stop the loader
        setLoader = false;
      } else {
        //-------show an error message
        AlertHelper.showAlert(context, "Validatioh error",
            "Required to fill all fields", DialogType.error);
      }
    } catch (e) {
      Logger().e(e);
      //--stop the loader
      setLoader = false;
    }
  }
}
