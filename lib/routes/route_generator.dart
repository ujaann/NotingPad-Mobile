import 'package:flutter/material.dart';
import 'package:notingpad/firestore_example/firestore_example.dart';
import 'package:notingpad/screens/form_screen.dart';
import 'package:notingpad/screens/home_screen.dart';
import 'package:notingpad/screens/login_screen.dart';
import 'package:notingpad/splash/splash_screen.dart';

class route_generator{

  static Route<dynamic>? generateRoute(RouteSettings settings){
    final arg=settings.arguments;
    print(settings.name);
    switch(settings.name){
      case "/splash":
        return MaterialPageRoute(builder: (_)=>const SplashScreen());
      case "/form":
        return MaterialPageRoute(builder: (_)=>const FormScreen());
      case "/firestore":
        return MaterialPageRoute(builder: (_)=>const FirestoreExample());
      case "/login":
        return MaterialPageRoute(builder: (_)=>const LoginScreen());
      case "/home":
        return MaterialPageRoute(builder: (_)=>const HomeScreen());
      default:
        return _pnf();
    }



}

static Route<dynamic> ? _pnf(){

    print("iamhere");
   return MaterialPageRoute(
         builder: (_)=>const Scaffold(body: Text("Page Not Found"),));
  }
 // static Route<> onPageNotFound() {

 //  }
}