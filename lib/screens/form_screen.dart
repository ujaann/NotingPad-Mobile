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
  final TextEditingController editEmail = TextEditingController();

  final _key = GlobalKey<FormState>();
  final database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Future Builder   //only one time listen
            StreamBuilder(
                stream: database.ref('users').onValue,
                builder: //listen multiple times
                    (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.data!.snapshot.value == null) {
                    return const Text("No data available");
                  }
                  print(snapshot.data!.snapshot.value);
                  // print(snapshot.data!.snapshot.value.runtimeType);
                  Map<dynamic, dynamic> _datas =
                      snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> value = _datas.values.toList();
                  List<dynamic> key = _datas.keys.toList();
                  print(key);
                  print(value);

                  return ListView.builder(
                    // itemBuilder is like for loop
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                database
                                    .ref()
                                    .child('users')
                                    .child(key[index])
                                    .remove();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.lightGreen,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  editEmail.text =
                                      value[index]['email'].toString();
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Edit data"),
                                    content: Container(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: editEmail,
                                          ),
                                          ElevatedButton(
                                              onPressed: () async {
                                                var datas = {
                                                  "email": editEmail.text
                                                };
                                                await database
                                                    .ref()
                                                    .child('users')
                                                    .child(key[index])
                                                    .update(datas);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Ediyt"))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                        title: Text(value[index]['email'].toString()),
                      );
                    },
                  );
                }),
            TextFormField(
                // validator: (datas){},
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
                onPressed: () async {
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
                      .push() //random id
                      .set(datas)
                      .then((value) {
                    print("suceess");
                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                },
                child: Text("submit"))
          ],
        ),
      ),
    );
  }
}
