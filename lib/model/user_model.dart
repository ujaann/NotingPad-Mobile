// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  // int? id;
  String? email;
  String? firstname;
  String? lastname;
  String? image;

  UserModel(
      {
        // required this.id,
      required this.email,
      this.firstname,
      this.lastname,
      this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        // id: json["id"],
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "image": image,
      };
}
