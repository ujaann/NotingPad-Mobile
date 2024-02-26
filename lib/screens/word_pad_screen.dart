import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notingpad/model/note_model.dart';
import 'package:notingpad/providers/note_view_model.dart';
import 'package:provider/provider.dart';

class WordsScreen extends StatefulWidget {
  NoteModel note;
  bool isNewNote;
  String? referenceId;
  WordsScreen(
      {super.key,
      required this.note,
      required this.isNewNote,
      this.referenceId});
  static const String routeName = "/note";

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  QuillController _controller = QuillController.basic();
  // final firestore=FirebaseFirestore.instance;
  late User _user;
  late NoteViewModel noteViewModel;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      noteViewModel = Provider.of<NoteViewModel>(context, listen: false);
    });

    loadExistingNote();
  }

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc,
          selection: TextSelection(baseOffset: 0, extentOffset: 0));
    });
  }

  void addNewNote(NoteViewModel viewModel) {
    String text = _controller.document.toPlainText();
    widget.note.text = text;
    viewModel.saveNotes(widget.note);
  }

  void updateNote(NoteViewModel viewModel) {
    String text = _controller.document.toPlainText();
    widget.note.text = text;
    widget.note.userId = _user.uid;
    print(widget.note);
    viewModel.updateNotes(widget.referenceId, widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Consumer<NoteViewModel>(builder: (context, value, child) {
        return IconButton(
          onPressed: () {
            print(_controller.changes.length);
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote(value);
            } else {
              updateNote(value);
            }
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        );
      })),
      //Get userId and noteId not separate the diferent notes
      body: Column(
        children: [
          QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                  controller: _controller,
                  multiRowsDisplay: true,
                  showSubscript: false,
                  showSuperscript: false,
                  showUndo: false,
                  showRedo: false)),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(20),
            child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                    controller: _controller, readOnly: false)),
          ))
        ],
      ),
    );
  }
}
