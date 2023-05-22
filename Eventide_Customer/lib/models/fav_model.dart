import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/models/user_model.dart';

class FavouriteModel {
  UserModel user;
  OrganizerModel organizer;

  FavouriteModel(
    this.user,
    this.organizer,
  );

  //-------this named constructor will bind json data to our model
  FavouriteModel.fromJason(Map<String, dynamic> json)
      : user = UserModel.fromJason(json['user'] as Map<String, dynamic>),
        organizer =
            OrganizerModel.fromJason(json['organizer'] as Map<String, dynamic>);
}
