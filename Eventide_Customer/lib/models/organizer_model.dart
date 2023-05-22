class OrganizerModel {
  String uid;
  String email;
  String name;
  String address;
  String description;
  String mobile;
  String price;
  String web;
  bool wedding;
  bool bday;
  bool engage;
  bool aniversary;
  bool office;
  bool exhibition;
  String fav;
  String img;
  String lastSeen;
  bool isOnline;
  String token;

  OrganizerModel(
      this.uid,
      this.email,
      this.name,
      this.address,
      this.description,
      this.mobile,
      this.price,
      this.web,
      this.wedding,
      this.bday,
      this.engage,
      this.aniversary,
      this.office,
      this.exhibition,
      this.fav,
      this.img,
      this.lastSeen,
      this.isOnline,
      this.token);

  //-------this named constructor will bind json data to our model
  OrganizerModel.fromJason(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        email = json['email'],
        address = json['address'],
        price = json['price'],
        description = json['description'],
        mobile = json['mobile'],
        web = json['web'],
        wedding = json['wedding'],
        bday = json['bday'],
        engage = json['engage'],
        aniversary = json['aniversary'],
        office = json['office'],
        exhibition = json['exhibition'],
        fav = json['fav'],
        lastSeen = json['lastSeen'],
        isOnline = json['isOnline'],
        token = json['token'],
        img = json['img'];

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'address': address,
        'price': price,
        'description': description,
        'mobile': mobile,
        'web': web,
        'wedding': wedding,
        'bday': bday,
        'engage': engage,
        'aniversary': aniversary,
        'office': office,
        'exhibition': exhibition,
        'img': img,
        'lastSeen': lastSeen,
        'isOnline': isOnline,
        'token': token,
        'fav': fav,
      };
}
