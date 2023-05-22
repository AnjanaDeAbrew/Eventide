import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class ChatController {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference conversations =
      FirebaseFirestore.instance.collection('conversations');

  //----------retreive conversation stream
  Stream<QuerySnapshot> getConversations(String currentUserId) => conversations
      .orderBy('createdAt', descending: true)
      .where('users', arrayContainsAny: [currentUserId]).snapshots();

  //-message sent fuction
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  Future<void> sendMessage(
    String conId,
    String senderName,
    String senderId,
    String reciveId,
    String message,
  ) async {
    try {
      await messages.add({
        "conId": conId,
        "senderName": senderName,
        "senderId": senderId,
        "reciveId": reciveId,
        "message": message,
        "messageTime": DateTime.now().toString(),
        "createdAt": DateTime.now(),
      });
      //----update the conversation lastmesage
      await conversations.doc(conId).update({
        'lastMessage': message,
        'lastMessageTime': DateTime.now().toString(),
        'createdAt': DateTime.now()
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //----------retreive message stream
  Stream<QuerySnapshot> getMessages(String conId) => messages
      .orderBy('createdAt', descending: true)
      .where('conId', isEqualTo: conId)
      .snapshots();
}
