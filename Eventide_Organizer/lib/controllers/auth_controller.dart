import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_organizer_app/controllers/file_upload_controller.dart';
import 'package:eventide_organizer_app/models/organizer_model.dart';
import 'package:eventide_organizer_app/utils/alert_helper.dart';
import 'package:eventide_organizer_app/utils/assets_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthController {
  //----signup user
  Future<void> signupOrganizer(
      String email,
      String password,
      String name,
      String address,
      String description,
      String initCode,
      String price,
      String web,
      bool wedding,
      bool bday,
      bool engage,
      bool aniversary,
      bool office,
      bool exhibition,
      String fav,
      String lastSeen,
      bool isOnline,
      String token,
      // File file,
      BuildContext context) async {
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
        saveOrganizerData(
          credential.user!.uid,
          email,
          name,
          address,
          description,
          initCode,
          price,
          web,
          wedding,
          bday,
          engage,
          aniversary,
          office,
          exhibition,
          fav,
          lastSeen,
          isOnline,
          token,
          // file
        );
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
  CollectionReference organizers =
      FirebaseFirestore.instance.collection('organizers');

  //----save extra user data in firestore
  Future<void> saveOrganizerData(
    String uid,
    String email,
    String name,
    String address,
    String description,
    String initCode,
    String price,
    String web,
    bool wedding,
    bool bday,
    bool engage,
    bool aniversary,
    bool office,
    bool exhibition,
    String fav,
    String lastSeen,
    bool isOnline,
    String token,

    // File file
  ) async {
    return organizers
        .doc(uid)
        .set(
          {
            'uid': uid,
            'email': email,
            'name': name,
            'address': address,
            'description': description,
            'mobile': initCode,
            'price': price,
            'web': web,
            'wedding': wedding,
            'bday': bday,
            'engage': engage,
            'aniversary': aniversary,
            'office': office,
            'exhibition': exhibition,
            'fav': fav,
            'img': AssetConstant.dummyProfile,
            'lastSeen': lastSeen,
            'isOnline': isOnline,
            'token': token,
          },
        )
        .then((value) => Logger().i("Successfully added a organizer"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //----update description data in firestore
  Future<String> updateDescription(String uid, String description) async {
    await organizers.doc(uid).update(
      {
        'description': description,
      },
    );
    return description;
  }

  //----update description data in firestore
  Future<String> updateAddress(String uid, String address) async {
    await organizers.doc(uid).update(
      {
        'address': address,
      },
    );
    return address;
  }

  //----update description data in firestore
  Future<String> updateMobile(String uid, String mobile) async {
    await organizers.doc(uid).update(
      {
        'mobile': mobile,
      },
    );
    return mobile;
  }

  //----update description data in firestore
  Future<String> updatePrice(String uid, String price) async {
    await organizers.doc(uid).update(
      {
        'price': price,
      },
    );
    return price;
  }

  //---fetch organizer list from cloudfirestore
  Stream<QuerySnapshot> getOrganizers() => organizers.snapshots();

  Future<OrganizerModel?> fetchOrganizerData(
      String uid, BuildContext context) async {
    try {
      //----------------firebase query that find and fetch user data according to the uid
      DocumentSnapshot documentSnapshot = await organizers.doc(uid).get();
      Logger().i(documentSnapshot.data());

      //---mapping fetched data user data into usermodel
      OrganizerModel model = OrganizerModel.fromJason(
          documentSnapshot.data() as Map<String, dynamic>);

      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //----login organizer
  Future<void> loginOrganizer(
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
      AlertHelper.showAlert(context, "Error", e.code, DialogType.error);
    } catch (e) {
      Logger().e(e);
      AlertHelper.showAlert(context, "Error", e.toString(), DialogType.error);
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
  Future<void> signOutOrganizer() async {
    await FirebaseAuth.instance.signOut();
  }

  //------file upload controller object
  final FileUploadController _fileUploadController = FileUploadController();

  //---------upload picked image file to firebase storage
  Future<String> uploadAndUpdatePickedImage(File file, String uid) async {
    try {
      //------first upload and get the download link of he picked file
      String downloadUrl =
          await _fileUploadController.uploadFile(file, "organizerImages");

      if (downloadUrl != "") {
        //------updating the uploaded file download url in the user data
        await organizers.doc(uid).update(
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

  //---update the current organizer online status and the last seen

  void updateOnlineStatus(String uid, bool isOnline) async {
    await organizers
        .doc(uid)
        .update({'isOnline': isOnline, 'lastSeen': DateTime.now().toString()})
        .then((value) => Logger().i("updated isonline and lastseen"))
        .catchError((error) => Logger().e("Failed to updated status"));
  }
}
