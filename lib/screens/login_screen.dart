import 'package:flutter/material.dart';
import 'package:notingpad/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool notLogin = false;

  void _navigateTo(String route) async {
    await Future.delayed(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        shape: const LinearBorder(),
        elevation: 0.5,
        shadowColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextFormField(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      label: Text("Username"),
                      floatingLabelAlignment: FloatingLabelAlignment.center)),
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: const InputDecoration(
                      label: Text("Password"),
                      floatingLabelAlignment: FloatingLabelAlignment.center)),
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Login", style: TextStyle(color: Colors.black)),
              ),
            ),
            AnimatedCrossFade(
              crossFadeState: notLogin
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Padding(
                padding: const EdgeInsets.all(9.0),
                child: InkWell(
                  child: const Text("Wont login"),
                  onTap: () {
                    setState(() {
                      notLogin = !notLogin;
                      print(notLogin);
                    });
                  },
                ),
              ),
              secondChild: Padding(
                padding: const EdgeInsets.all(9.0),
                child: InkWell(
                  onTap: () {
                    _navigateTo(HomeScreen.routeName);
                  },
                  child: const Text("Press Here"),
                ),
              ),
              duration: const Duration(seconds: 3),
            )
          ],
        ),
      ),
    );
  }
}
