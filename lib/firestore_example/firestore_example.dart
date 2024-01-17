import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notingpad/model/user_model.dart';
import 'package:notingpad/providers/user_view_model.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';

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

  ImagePicker picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  File? image;
  String? url;
  late UserViewModel userViewModel;

  @override
  void initState() {
    // TODO: implement initState
    // addPostFrameCallBack((timeStamp){ userViewModel=Provider.of(context,false);});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userViewModel = Provider.of(context, listen: false);
      userViewModel.getUsers();
    });
    //week5 design
    super.initState();
  }

  void pickImage(ImageSource source) async {
    var selected = await picker.pickImage(source: source, imageQuality: 100);
    if (selected == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No image selected")));
    } else {
      setState(() {
        image = File(selected.path);
        print(image!.path.split('/'));
        saveToStorage();
      });
    }
  }

  void saveToStorage() async {
    String name = image!.path.split('/').last;
    final photo = await storage
        .ref()
        .child('users')
        .child(name)
        .putFile(File(image!.path));
    String tempUrl = await photo.ref.getDownloadURL();
    setState(() {
      url = tempUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UserViewModel>(
        builder: (context, value, child) {
          return ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
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
              image == null
                  ? SizedBox()
                  : Image.file(image!, height: 200, width: 200),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Choose image"),
                              content: Container(
                                height: 150,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        pickImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/camera.png",
                                            height: 100,
                                            width: 100,
                                          ),
                                          Text("Camera")
                                        ],
                                      ),
                                    )),
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        pickImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/gallery.png",
                                            height: 100,
                                            width: 100,
                                          ),
                                          Text("Gallery")
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Text("Hlo img")),
              value.loading == true
                  ? const CircularProgressIndicator()
                  : value.data.isEmpty
                      ? const Text("No data")
                      : Column(
                          children: value.data.map((e) {
                          var user = e.data();
                          return ListTile(
                            title: Text(user.email ?? "n/a"),
                            subtitle: Text(user.firstname ?? "n/a"),
                            leading: user.image == null
                                ? Image.asset("assets/images/default_profile.png")
                                : Image.network(user.image.toString()),
                          );
                        }).toList()),
              ElevatedButton(
                  onPressed: () async {
                    OverlayLoadingProgress.start();

                    UserModel model = UserModel(
                        email: email.text,
                        firstname: fname.text,
                        lastname: lname.text,
                        image: url);
                    value.saveUsers(model);
                    await firestore
                        .collection('users')
                        .doc()
                        .set(model.toJson())
                        .then((value) {
                      email.clear();
                      fname.clear();
                      lname.clear();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Data Submitted"),
                        backgroundColor: Colors.lightGreen,
                      ));
                      OverlayLoadingProgress.stop();
                    }).onError((error, stackTrace) {
                      OverlayLoadingProgress.stop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error.toString()),
                        backgroundColor: Colors.deepOrange,
                      ));
                    });
                  },
                  child: Text("Submit")),
            ],
          );
        },
      ),
    );
  }
}
