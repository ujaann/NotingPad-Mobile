import 'package:flutter/material.dart';
import 'package:notingpad/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool not_login = false;

  void navigateTo(String route) async {
    print("ok");
    await Future.delayed(
      const Duration(milliseconds: 9),
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
                  decoration: InputDecoration(
                      label: Text("Username"),
                      floatingLabelAlignment: FloatingLabelAlignment.center)),
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                      label: Text("Password"),
                      floatingLabelAlignment: FloatingLabelAlignment.center)),
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Login", style: TextStyle(color: Colors.black)),
              ),
            ),
            AnimatedCrossFade(
              crossFadeState: not_login
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Padding(
                padding: const EdgeInsets.all(9.0),
                child: InkWell(
                  child: Text("Wont login"),
                  onTap: () {
                    setState(() {
                      not_login = !not_login;
                      print(not_login);
                    });
                  },
                ),
              ),
              secondChild: Padding(
                padding: const EdgeInsets.all(9.0),
                child: InkWell(
                  onTap: () {
                    //TODO  Redirect to home dashboard
                    navigateTo(HomeScreen.routeName);
                  },
                  child: Text("Press Here"),
                ),
              ),
              duration: Duration(seconds: 3),
            )
          ],
        ),
      ),
    );
  }
}
