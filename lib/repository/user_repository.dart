import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notingpad/model/user_model.dart';

class UserRepository {
  final instance = FirebaseFirestore.instance.collection('users').withConverter(
      fromFirestore: (snapshot, options) =>
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>),
      toFirestore: (UserModel value, options) => value.toJson());

  // void saveUser(){}

  //Asynchronous use future prob like promise
  Future<dynamic> saveUsers(UserModel data) async{
    try {
      final result=await instance.add(data);
      return result;
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
  Future<List<QueryDocumentSnapshot<UserModel>>> fetchUsers() async{
    try {
      final res=(await instance.get()).docs;
      return res;
    } on Exception catch (e) {
      // TODO
    }
    return [];
  }



}
