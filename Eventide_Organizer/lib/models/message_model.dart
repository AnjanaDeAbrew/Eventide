class MessageModel {
  MessageModel(
    this.conId,
    this.senderName,
    this.senderId,
    this.reciveId,
    this.message,
    this.messageTime,
  );
  String conId;
  String senderName;
  String senderId;
  String reciveId;
  String message;
  String messageTime;

  //-------this named constructor will bind json data to our model
  MessageModel.fromJason(Map<String, dynamic> json)
      : conId = json['conId'],
        senderName = json['senderName'],
        senderId = json['senderId'],
        reciveId = json['reciveId'],
        message = json['message'],
        messageTime = json['messageTime'];
}
