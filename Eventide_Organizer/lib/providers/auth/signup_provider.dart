import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventide_organizer_app/controllers/auth_controller.dart';
import 'package:eventide_organizer_app/utils/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SignupProvider extends ChangeNotifier {
  //--------------admin controller object
  final AuthController _authController = AuthController();

//---description controler
  final _description = TextEditingController();

  //--- get description controller
  TextEditingController get descriptionController => _description;

  //---OrganizerName controller
  final _name = TextEditingController();

//--- get OrganizerName controller
  TextEditingController get nameController => _name;

  //---OrganizerName controller
  final _email = TextEditingController();

//--- get OrganizerName controller
  TextEditingController get emailController => _email;

  //---OrganizerPassword controller
  final _password = TextEditingController();

//--- get OrganizerPassword controller
  TextEditingController get passwordController => _password;

  //---Town controler
  final _address = TextEditingController();

  //--- get Town controller
  TextEditingController get addressController => _address;

  //---Price controler
  final _price = TextEditingController();

  //--- get Price controller
  TextEditingController get priceController => _price;

  //---Mobile  controler
  final _web = TextEditingController();

  //--- get Mobile controller
  TextEditingController get web => _web;

//-------------------category check
  //---category wedding controler
  bool _wedding = false;

  //--- get category wedding controller
  bool get wedding => _wedding;

  //-----set category wedding state
  set setWedding(bool wVal) {
    _wedding = wVal;
    notifyListeners();
  }

  //---category birthday controler
  bool _bday = false;

  //--- get category birthday controller
  bool get bday => _bday;

  //-----set category birthday state
  set setBday(bool bVal) {
    _bday = bVal;
    notifyListeners();
  }

  //---category engagement controler
  bool _engage = false;

  //--- get category engagement controller
  bool get engage => _engage;

  //-----set category engagement state
  set setEngage(bool eVal) {
    _engage = eVal;
    notifyListeners();
  }

  //---category aniversary controler
  bool _aniversary = false;

  //--- get category aniversary controller
  bool get aniversary => _aniversary;

  //-----set category aniversary state
  set setAniversary(bool aVal) {
    _aniversary = aVal;
    notifyListeners();
  }

  //---category office controler
  bool _office = false;

  //--- get category office controller
  bool get office => _office;

  //-----set category office state
  set setOffice(bool oVal) {
    _office = oVal;
    notifyListeners();
  }

  //---category exhibition controler
  bool _exhibition = false;

  //--- get category exhibition controller
  bool get exhibition => _exhibition;

  //-----set category exhibition state
  set setExhibition(bool exVal) {
    _exhibition = exVal;
    notifyListeners();
  }

//----loading state
  bool _isLoading = false;

  //get loader state
  bool get isLoading => _isLoading;

  //-----set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  String _initCode = '';
  String get initCode => _initCode;
  set setInitCode(String value) {
    _initCode = value;
    notifyListeners();
  }

  String fav = 'false';

  //-start saving organizer data
  Future<void> startSignupOrganizer(BuildContext context) async {
    try {
      //-start the loader
      setLoader = true;

      if (_email.text.isNotEmpty &&
          _password.text.isNotEmpty &&
          _name.text.isNotEmpty &&
          _address.text.isNotEmpty &&
          _description.text.isNotEmpty &&
          _price.text.isNotEmpty &&
          _initCode.isNotEmpty &&
          _web.text.isNotEmpty) {
        //---start the loader
        setLoader = true;

        //----start creating the user account
        await AuthController().signupOrganizer(
            _email.text,
            _password.text,
            _name.text,
            _address.text,
            _description.text,
            _initCode,
            _price.text,
            _web.text,
            _wedding,
            _bday,
            _engage,
            _aniversary,
            _office,
            _exhibition,
            fav,
            DateTime.now().toString(),
            true,
            "token",
            context);

        //----stop the loader
        setLoader = false;
      } else {
        //-----shows a error dialog
        AlertHelper.showAlert(context, "Validation error",
            "Fill all the fields", DialogType.error);
      }
    } catch (e) {
      Logger().e(e);
      //-stop the loader
      setLoader = false;
    }
  }
}
