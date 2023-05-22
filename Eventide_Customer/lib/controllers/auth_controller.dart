import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/controllers/file_upload_controller.dart';
import 'package:eventide_app/models/user_model.dart';
import 'package:eventide_app/utils/alert_helper.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthController {
  //----signup user
  Future<void> signupUser(String email, String password, String name,
      String mobile, BuildContext context) async {
    try {
      //----start creating the user in the firebase console
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //----------check user object is not null
      if (credential.user != null) {
        //------save extra user data in firestore cloud
        saveUserData(credential.user!.uid, email, name, mobile);
      }
      Logger().i(credential);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      AlertHelper.showAlert(context, "Error", e.code, DialogType.error);
    } catch (e) {
      Logger().e(e);
      AlertHelper.showAlert(context, "Error", e.toString(), DialogType.error);
    }
  }

  //--------============================saving user data in cloud firestore======================
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //----save extra user data in firestore
  Future<void> saveUserData(
      String uid, String email, String name, String mobile) {
    return users
        .doc(uid)
        .set(
          {
            'uid': uid,
            'email': email,
            'name': name,
            'mobile': mobile,
            'img': AssetConstant.dummyProfile,
            'coverImg': AssetConstant.coverImage,
          },
        )
        .then((value) => Logger().i("Successfully added"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //---fetch userdata from cloudfirestore

  Future<UserModel?> fetchUserData(String uid) async {
    try {
      //----------------firebase query that find and fetch user data according to the uid
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Logger().i(documentSnapshot.data());

      //---mapping fetched data user data into usermodel
      UserModel model =
          UserModel.fromJason(documentSnapshot.data() as Map<String, dynamic>);

      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //----login user
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      //----start login in the user in the firebase console
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger().i(credential);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      AlertHelper.showAlertLogin(context, "Error", e.code, DialogType.error);
    } catch (e) {
      Logger().e(e);
      AlertHelper.showAlertLogin(
          context, "Error", e.toString(), DialogType.error);
    }
  }

  //----reset password email
  static Future<void> sendResetPassEmail(
      String email, BuildContext context) async {
    try {
      //----start sending apassword reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      AlertHelper.showAlert(context, "Error", e.code, DialogType.error);
    } catch (e) {
      Logger().e(e);
      AlertHelper.showAlert(context, "Error", e.toString(), DialogType.error);
    }
  }

  //------signout user
  static Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  //===================================upload user image
  final FileUploadController _fileUploadController = FileUploadController();

//---------upload picked image file to firebase storage
  Future<String> uploadAndUpdatePickedImage(File file, String uid) async {
    try {
      //------first upload and get the download link of he picked file
      String downloadUrl =
          await _fileUploadController.uploadFile(file, "profileImages");

      if (downloadUrl != "") {
        //------updating the uploaded file download url in the user data
        await users.doc(uid).update(
          {
            'img': downloadUrl,
          },
        );
        return downloadUrl;
      } else {
        Logger().e("download url is empty");
        return "";
      }
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  //---------upload picked cover image file to firebase storage
  Future<String> uploadAndUpdatePickedCoverImage(File file, String uid) async {
    try {
      //------first upload and get the download link of he picked file
      String downloadUrl =
          await _fileUploadController.uploadFile(file, "coverImages");

      if (downloadUrl != "") {
        //------updating the uploaded file download url in the user data
        await users.doc(uid).update(
          {
            'coverImg': downloadUrl,
          },
        );
        return downloadUrl;
      } else {
        Logger().e("download url is empty");
        return "";
      }
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }
}
