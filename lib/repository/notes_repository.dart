import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notingpad/model/note_model.dart';

class NotesRepository {
  final instance = FirebaseFirestore.instance.collection('notes').withConverter(
      fromFirestore: (snapshot, options) =>
          NoteModel.fromJson(snapshot.data() as Map<String, dynamic>),
      toFirestore: (NoteModel value, options) => value.toJson());
}
