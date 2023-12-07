import 'package:flutter/material.dart';

class route_generator{

  static Route<dynamic>? generateRoute(RouteSettings settings){
    final arg=settings.arguments;
    switch(settings.name){
      case "/splash":
        return MaterialPageRoute(builder: (_)=>const Scaffold());
      default:
        _onPageNotFound();
    }
  }

  static Route<dynamic> _onPageNotFound() {
    return MaterialPageRoute(
        builder: (_)=>const Scaffold(body: Text("Page Not Found"),));
  }
}