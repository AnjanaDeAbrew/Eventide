import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FavController {
  //--------============================saving user data in cloud firestore======================
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference favs = FirebaseFirestore.instance.collection('fav');
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference organizers =
      FirebaseFirestore.instance.collection('organizers');
  CollectionReference favOrganizers =
      FirebaseFirestore.instance.collection('favOrganizers');
  late DocumentReference _documentReference;
  late CollectionReference _collectionReference;

  Future<void> saveFav(
      UserModel user, OrganizerModel organizer, BuildContext context) async {
    await favs.doc(user.uid).set({
      'user': user.toJson(),
    });
    _documentReference = favs.doc(user.uid);
    _collectionReference = _documentReference.collection('favOrganizers');
    _collectionReference.doc(organizer.uid).set(
      {
        'uid': organizer.uid,
        'email': organizer.email,
        'name': organizer.name,
        'address': organizer.address,
        'description': organizer.description,
        'mobile': organizer.mobile,
        'price': organizer.price,
        'web': organizer.web,
        'wedding': organizer.wedding,
        'bday': organizer.bday,
        'engage': organizer.engage,
        'aniversary': organizer.aniversary,
        'office': organizer.office,
        'exhibition': organizer.exhibition,
        'fav': organizer.fav,
        'img': organizer.img,
        'lastSeen': organizer.lastSeen,
        'isOnline': organizer.isOnline,
        'token': organizer.token,
      },
    ).then((value) {
      return _collectionReference.doc(organizer.uid).update({'fav': 'true'});
    }).then((value) {
      return organizers.doc(organizer.uid).update({'fav': 'true'});
    });
  }

  Stream<QuerySnapshot> getFavs(String userId) =>
      favs.doc(userId).collection('favOrganizers').snapshots();

  //---fetch review list from cloudfirestore

  Future<List<OrganizerModel>> fetchFavist(String userId) async {
    try {
      //----------------firebase query that find by user id and fetch booking collection
      QuerySnapshot querySnapshot =
          await favs.doc(userId).collection('favOrganizers').get();
      Logger().i(querySnapshot.docs.length);

      //temp organizer list
      List<OrganizerModel> list = [];

      for (var e in querySnapshot.docs) {
        //------------mapping product data into organizer model
        OrganizerModel model =
            OrganizerModel.fromJason(e.data() as Map<String, dynamic>);

        //---adding to the product list
        list.add(model);
      }

      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<void> removeFromFav(
    String userId,
    String orgId,
    BuildContext context,
  ) async {
    await favs
        .doc(userId)
        .collection('favOrganizers')
        .doc(orgId)
        .delete()
        .then((value) {
      return organizers.doc(orgId).update({'fav': 'false'});
    });
  }
}
