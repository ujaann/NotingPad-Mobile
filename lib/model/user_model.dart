// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? firstname;
  String? lastname;
  String ? image;

  UserModel({
    required this.email,
    this.firstname,
    this.lastname,
    this.image
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "image": image,
      };
}
