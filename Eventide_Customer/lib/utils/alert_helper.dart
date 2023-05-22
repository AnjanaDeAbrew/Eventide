import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';

class AlertHelper {
  static Future<void> showAlert(
    BuildContext context,
    String title,
    String desc,
    DialogType type,
  ) async {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        UtilFunction.goBack(context);
      },
    ).show();
  }

  static Future<void> showAlertLogin(
    BuildContext context,
    String title,
    String desc,
    DialogType type,
  ) async {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

//------show a snack bar
  static void showSnackBar(
    BuildContext context,
    String msg,
    AnimatedSnackBarType type,
  ) {
    AnimatedSnackBar.rectangle('Success', msg,
            type: type,
            brightness: Brightness.dark,
            duration: const Duration(microseconds: 400))
        .show(
      context,
    );
  }
}
