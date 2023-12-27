import 'package:flutter/material.dart';
import 'package:notingpad/form_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName="/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigate() async{
    await Future.delayed(const Duration(seconds: 3),() {
      Navigator.pushReplacementNamed(context, FormScreen.routeName);
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    navigate();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Navigator.push
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("SplashScreen"),
    );
  }
}
