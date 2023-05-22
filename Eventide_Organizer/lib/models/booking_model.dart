class BookingModel {
  BookingModel(
    this.uid,
    this.userName,
    this.userEmail,
    this.userMobile,
    this.orgUid,
    this.orgName,
    this.orgEmail,
    this.orgMobile,
    this.date,
    this.time,
    this.count,
    this.status,
    this.docId,
    this.dateTime,
    this.catValue,
  );
  String uid;
  String userName;
  String userEmail;
  String userMobile;
  String orgUid;
  String orgName;
  String orgEmail;
  String orgMobile;
  String date;
  String time;
  String count;
  String status;
  String docId;
  String dateTime;

  int catValue;

  //-------this named constructor will bind json data to our model
  BookingModel.fromJason(Map<String, dynamic> json)
      : uid = json['uid'],
        userName = json['userName'],
        userEmail = json['userEmail'],
        userMobile = json['userMobile'],
        orgUid = json['orgUid'],
        orgName = json['orgName'],
        orgEmail = json['orgEmail'],
        orgMobile = json['orgMobile'],
        date = json['date'],
        time = json['timeValue'],
        count = json['count'],
        status = json['status'],
        docId = json['docId'],
        dateTime = json['dateTime'],
        catValue = (json['catValue'] as num).toInt();
}
