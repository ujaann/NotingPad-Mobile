import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:notingpad/model/user_model.dart';
import 'package:notingpad/repository/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  bool _loading = false;
  List<QueryDocumentSnapshot<UserModel>> _data = [];

  bool get loading => _loading;

  List<QueryDocumentSnapshot<UserModel>> get data => _data;

  Future<dynamic> saveUsers(UserModel data) async {
    try {
      final result = await UserRepository().instance.add(data);
      return result;
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<QueryDocumentSnapshot<UserModel>>> fetchUsers() async {
    try {
      final res = (await UserRepository().instance.get()).docs;
      return res;
    } on Exception catch (e) {
      // TODO
    }
    return [];
  }

  Future<void> getUsers() async {
    loading=true;
    final res = await UserRepository().fetchUsers();
    data=res;
    loading=false;
    notifyListeners();
  }

  set data(List<QueryDocumentSnapshot<UserModel>> value) {
    _data = value;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
