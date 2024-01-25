import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName="/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        leading: Icon(Icons.menu),
        elevation: 1,
        shadowColor: Colors.grey,
      ),
      body: ListTile(
        title: Text("Hello"),
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add_rounded,color: Colors.blueGrey,size: 46,)),
    );
  }
}
