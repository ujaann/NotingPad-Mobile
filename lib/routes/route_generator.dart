import 'package:flutter/material.dart';
import 'package:notingpad/form_screen.dart';
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