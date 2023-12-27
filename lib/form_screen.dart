import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});
  static const String routeName = "/form";

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController email = TextEditingController();

  final _key = GlobalKey<FormState>();
  final database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Future Builder
          StreamBuilder(stream: database.ref('users').onValue, builder:
          (context, snapshot){
            print(snapshot.data!.snapshot.value);
            return Text("data");
          }
          )
          ,TextFormField(
            validator: (datas){},
              controller: fname,
              decoration: InputDecoration(label: Text("Firstname"))),
          TextFormField(
              controller: lname,
              decoration: InputDecoration(label: Text("Lastname"))),
          TextFormField(
              controller: contact,
              decoration: InputDecoration(label: Text("Contact"))),
          TextFormField(
              controller: address,
              decoration: InputDecoration(label: Text("Address"))),
          TextFormField(
              controller: email,
              decoration: InputDecoration(label: Text("Email"))),
          ElevatedButton(
              onPressed: () async{
                var datas = {
                  "firstname": fname.text,
                  "lastname": lname.text,
                  "contact": contact.text,
                  "address": address.text,
                  "email": email.text,
                };
                await database
                    .ref()
                    .child("users")
                    .push()
                    .set(datas).then((value) {
                      print("suceess");
                }).onError((error, stackTrace) {
                      print(error.toString());
                });
              },
              child: Text("submit"))
        ],
      ),
    );
  }
}
