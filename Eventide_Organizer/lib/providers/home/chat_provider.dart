import 'package:eventide_organizer_app/controllers/chat_controller.dart';
import 'package:eventide_organizer_app/models/conversation_model.dart';
import 'package:eventide_organizer_app/models/organizer_model.dart';
import 'package:eventide_organizer_app/models/user_model.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final ChatController _chatController = ChatController();

  int _loadingIndex = -1;
  int get loadingIndex => _loadingIndex;
  void setLoadingIndex([int i = -1]) {
    _loadingIndex = i;
    notifyListeners();
  }

  //-conversation model
  late ConversationModel _conversationModel;
  ConversationModel get conversationModel => _conversationModel;
  //-set model
  void setConversation(ConversationModel model) {
    _conversationModel = model;
    notifyListeners();
  }

  Future<void> startSendMessage(BuildContext context, String message) async {
    try {
      OrganizerModel me =
          Provider.of<UserProvider>(context, listen: false).organizerModel!;
      UserModel model = UserModel.fromJason(_conversationModel.usersArray[0]);

      await _chatController.sendMessage(
        _conversationModel.id,
        me.name,
        me.uid,
        model.uid,
        message,
      );
    } catch (e) {
      Logger().e(e);
    }
  }
}
