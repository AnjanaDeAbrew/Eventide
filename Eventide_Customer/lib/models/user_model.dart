class UserModel {
  String uid;
  String email;
  String name;
  String mobile;
  String img;
  String coverImg;

  UserModel(
      this.uid, this.email, this.name, this.mobile, this.img, this.coverImg);

  //-------this named constructor will bind json data to our model
  UserModel.fromJason(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        email = json['email'],
        mobile = json['mobile'],
        img = json['img'],
        coverImg = json['coverImg'];

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'mobile': mobile,
        'img': img,
        'coverImg': coverImg,
      };
}
