//import 'package:freezed_annotation/freezed_annotation.dart';
// TODO(dungnv): setup format on save and format whole project following dart style
class User {
  int id;
  String name;
  String? about;
  String? urlAvatar;
  User({required this.name,required this.id,this.about, this.urlAvatar});

  factory User.fromJson(dynamic jsonObject){
    final user = jsonObject['User'];

    // TODO(dungnv): should enter here before a block code or condition to clear 
    return User(
        name: user['name'],
        id: user['id'],
        about: user['about'],
        urlAvatar: user['avatar']['medium']
    );
  }
}