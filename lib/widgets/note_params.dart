import 'package:notingpad/model/note_model.dart';

class NoteParams{
  final NoteModel note;
  final bool isNewNote;
  final String ?referenceId;

  NoteParams({required this.note, required this.isNewNote,this.referenceId});
}