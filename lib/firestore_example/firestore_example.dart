import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notingpad/model/user_model.dart';
import 'package:overlay_kit/overlay_kit.dart';

class FirestoreExample extends StatefulWidget {
  const FirestoreExample({super.key});
  static const String routeName = "/firestore";

  @override
  State<FirestoreExample> createState() => _FirestoreExampleState();
}

class _FirestoreExampleState extends State<FirestoreExample> {
  TextEditingController email = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email"),
          TextFormField(controller: email),
          Text("FirstName"),
          TextFormField(
            controller: fname,
          ),
          Text("LastName"),
          TextFormField(
            controller: lname,
          ),
          ElevatedButton(
              onPressed: () async {
                OverlayLoadingProgress.start();

                UserModel model=UserModel(email: email.text,firstname: fname.text,lastname: lname.text);
                await firestore
                    .collection('users')
                    .doc()
                    .set(model.toJson())
                    .then((value) {
                  email.clear();
                  fname.clear();
                  lname.clear();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Data Submitted"),backgroundColor: Colors.lightGreen,));
                  OverlayLoadingProgress.stop();
                }).onError((error, stackTrace) {
                  OverlayLoadingProgress.stop();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString()),backgroundColor: Colors.deepOrange,));
                });
              },
              child: Text("Submit")),
        ],
      ),
    );
  }
}
