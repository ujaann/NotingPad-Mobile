import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notingpad/model/note_model.dart';
import 'package:notingpad/providers/note_view_model.dart';
import 'package:notingpad/splash/splash_screen.dart';
import 'package:notingpad/widgets/note_params.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NoteViewModel noteViewModel;
  late StreamSubscription<User?> _userSubscription;
  late User _user;
  bool justStart = false;
  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;

    // Detect when a user signs in or out
    _userSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        if (user != null) {
          setState(() {
            _user = FirebaseAuth.instance.currentUser!;
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              noteViewModel =
                  Provider.of<NoteViewModel>(context, listen: false);
              noteViewModel.getNotes(_user.uid);
            });
          });
        } else {
          setState(() {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/splash',
                (_) => false,
              );
            });
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  void createNewNote() {
    if (kDebugMode) {
      print(_user);
    }
    goToWordPage(NoteModel(text: "Start Here", userId: _user.uid), true);
  }

  void openExistingNote(NoteModel note) {
    goToWordPage(note, false);
  }

  void goToWordPage(NoteModel note, bool isNew) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Loading"),shape: BeveledRectangleBorder(),padding: EdgeInsets.all(20),));

    Navigator.of(context).pushNamed('/note',
        arguments: NoteParams(note: note, isNewNote: isNew));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        scrolledUnderElevation: 3,
        elevation: 1,
        shadowColor: Colors.grey,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black12,
          child: ListView(
            children: [
              const DrawerHeader(
                  child: Center(
                child: Text(
                  "NotingPad",
                  style: TextStyle(fontSize: 25),
                ),
              )),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text("Email: ${(_user.email)}\n"
                    "Id: ${(_user.uid)}\n"),
              ),
              ListTile(
                leading: const Icon(Icons.refresh_rounded),
                title: const Text("Reload"),
                onTap: () {
                  noteViewModel.getNotes(_user.uid);
                },
              ),
              ListTile(
                minVerticalPadding: 90,
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text("Logout"),
                  onTap: () {
                    _userSubscription.cancel();
                    Navigator.pushReplacementNamed(
                        context, SplashScreen.routeName);
                  }),

            ],
          ),
        ),
      ),
      body: Consumer<NoteViewModel>(builder: (context, value, child) {
        return value.loading && !justStart == true
            ? const Center(child: CircularProgressIndicator())
            : value.data.isEmpty
                ? const Center(child: Text("No notes Start Writing.",style: TextStyle(fontSize: 20),))
                : ListView(
                    padding: const EdgeInsets.all(10),
                    children: value.data.map((e) {
                      var note = e.data();
                      var noteId=e.id;
                      print(e.data());
                      return Dismissible(
                        background: Container(
                          color: Colors.lightGreen,
                          alignment: Alignment.centerRight,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.delete),
                          ),
                        ),
                        movementDuration: const Duration(seconds: 4),
                        dismissThresholds: const {
                          DismissDirection.endToStart: 0.7
                        },
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) async {
                          return await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Confirm'),
                                content: const Text(
                                    'Do you want to delete this item?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      value.deleteNotes(noteId, note);
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (DismissDirection dir){
                          setState( () {
                            justStart = true;
                            value.data.removeWhere((item) => item.id == e.id);
                          });
                        },
                        key: Key(e.id),
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 45),
                          title: Text(note.text,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(e.id),
                          ),
                          shape: const Border(bottom: BorderSide()),
                          enableFeedback: true,
                          onTap: () {
                            justStart = true;
                            openExistingNote(note);
                          },
                        ),
                      );
                    }).toList(),
                  );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          justStart = true;
          setState(() {
            createNewNote();
          });
          if (kDebugMode) {
            print("Hello2");
          }
        },
        backgroundColor: Colors.white,
        elevation: 3,
        splashColor: Colors.amberAccent,
        tooltip: "Create new note.",
        child: const Icon(
          Icons.add_rounded,
          color: Colors.blueGrey,
          size: 46,
        ),
      ),
    );
  }
}
