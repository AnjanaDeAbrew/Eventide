import 'package:eventide_app/controllers/chat_controller.dart';
import 'package:eventide_app/models/conversation_model.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/models/user_model.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/screens/main/chat/chats/chat_screen.dart';
import 'package:eventide_app/utils/util_functions.dart';
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

  Future<void> startCreateConversation(
      BuildContext context, OrganizerModel peeruser, int i) async {
    try {
      UserModel me =
          Provider.of<UserProvider>(context, listen: false).userModel!;

      setLoadingIndex(i);
      _conversationModel =
          await _chatController.createConersation(me, peeruser);
      notifyListeners();

      setLoadingIndex();

      // ignore: use_build_context_synchronously
      UtilFunction.navigateTo(
          context, ChatScreen(conId: _conversationModel.id));
    } catch (e) {
      setLoadingIndex();
      Logger().e(e);
    }
  }

  Future<void> startSendMessage(BuildContext context, String message) async {
    try {
      UserModel me =
          Provider.of<UserProvider>(context, listen: false).userModel!;
      OrganizerModel model =
          OrganizerModel.fromJason(_conversationModel.usersArray[1]);

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
