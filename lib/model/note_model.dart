// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  // int id;
  String text;
  String userId;
  NoteModel({
    // required this.id,
    required this.text,
    required this.userId
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    // id: json["id"],
    text: json["text"],
    userId: json["userId"]
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "text": text,
    "userId":userId
  };
}
