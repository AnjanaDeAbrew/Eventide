import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:logger/logger.dart';

class OrganizerController {
  //--------============================saving user data in cloud firestore======================
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference organizers =
      FirebaseFirestore.instance.collection('organizers');

  Stream<QuerySnapshot> getOrganizers() => organizers.snapshots();

  //---fetch organizer list from cloudfirestore

  Future<List<OrganizerModel>> fetchOrganizerList() async {
    try {
      //----------------firebase query that find and fetch product collection
      QuerySnapshot querySnapshot = await organizers.get();
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

  //---update the current organizer online status and the last seen

  void updateOnlineStatus(String uid, bool isOnline) async {
    await organizers
        .doc(uid)
        .update({'isOnline': isOnline, 'lastSeen': DateTime.now().toString()})
        .then((value) => Logger().i("updated isonline and lastseen"))
        .catchError((error) => Logger().e("Failed to updated status"));
  }

  Stream<DocumentSnapshot> getPeerUserStatus(String uid) =>
      organizers.doc(uid).snapshots();
}
