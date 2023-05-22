class ConversationModel {
  ConversationModel(
    this.id,
    this.users,
    this.usersArray,
    this.lastMessage,
    this.lastMessageTime,
    this.createdBy,
  );
  String id;
  List<dynamic> users;
  List<dynamic> usersArray;
  String lastMessage;
  String lastMessageTime;
  String createdBy;

  //-------this named constructor will bind json data to our model
  ConversationModel.fromJason(Map<String, dynamic> json)
      : id = json['id'],
        users = json['users'],
        usersArray = json['usersArray'],
        lastMessage = json['lastMessage'],
        lastMessageTime = json['lastMessageTime'],
        createdBy = json['createdBy'];
}
