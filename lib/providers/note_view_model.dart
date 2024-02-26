import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:notingpad/model/note_model.dart';
import 'package:notingpad/repository/notes_repository.dart';

class NoteViewModel extends ChangeNotifier {
  bool _loading = false;
  List<QueryDocumentSnapshot<NoteModel>> _data = [];

  bool get loading => _loading;

  List<QueryDocumentSnapshot<NoteModel>> get data => _data;
  Future<dynamic> saveNotes(NoteModel data) async {
    try {
      final result = await NotesRepository().instance.add(data);
      getNotes(data.userId);
      return result;
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<QueryDocumentSnapshot<NoteModel>>> fetchNotes(String userId) async {
    try {
      final res =
          (await NotesRepository().instance.where("userId",isEqualTo:userId ).get());
      print(res.docs);
      return res.docs;
    } on Exception catch (e) {
      print(e.toString());
    }
    return [];
  }
  Future<dynamic> updateNotes(String ?referenceId,NoteModel data) async {
    try {
      final result = await NotesRepository().instance.doc(referenceId).update(data.toJson());
      return result;
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> deleteNotes(String ?referenceId,NoteModel data) async {
    try {
      final result = await NotesRepository().instance.doc(referenceId).delete();
      // getNotes(data.userId);
      return result;
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }


  Future<void> getNotes(String userId) async{
    loading=true;
    final res = await fetchNotes(userId);
    data=res;
    loading=false;
    notifyListeners();
  }

  set data(List<QueryDocumentSnapshot<NoteModel>> value) {
    _data = value;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
