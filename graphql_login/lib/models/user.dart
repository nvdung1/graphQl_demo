//import 'package:freezed_annotation/freezed_annotation.dart';

class User {
  int id;
  String name;
  String? about;
  String? urlAvatar;
  User({required this.name,required this.id,this.about, this.urlAvatar});

  factory User.fromJson(dynamic jsonObject){
    final user = jsonObject['User'];
    return User(
        name: user['name'],
        id: user['id'],
        about: user['about'],
        urlAvatar: user['avatar']['medium']
    );
  }
}