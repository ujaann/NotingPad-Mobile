import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:notingpad/firestore_example/firestore_example.dart';
import 'package:notingpad/screens/form_screen.dart';
import 'package:notingpad/screens/home_screen.dart';
import 'package:notingpad/screens/login_screen.dart';
import 'package:notingpad/screens/word_pad_screen.dart';
import 'package:notingpad/splash/splash_screen.dart';
import 'package:notingpad/widgets/note_params.dart';

class route_generator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    print(settings.name);
    switch (settings.name) {
      case "/splash":
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case "/form":
        return MaterialPageRoute(builder: (_) => const FormScreen());
      case "/firestore":
        return MaterialPageRoute(builder: (_) => const FirestoreExample());
      // case "/login":
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      case "/home":
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case "/note":
        if (arg is NoteParams) {
          // Extracting parameters
          NoteParams params = arg;
          return MaterialPageRoute(builder: (_) => WordsScreen(note: params.note, isNewNote: params.isNewNote,referenceId: params.referenceId,));
        }
      case "/login":
        return MaterialPageRoute(
            builder: (_) => SignInScreen(
                  actions: [

                    AuthStateChangeAction(
                      (context, state) {
                        if (state is UserCreated || state is SignedIn) {
                          var user = (state is SignedIn)
                              ? state.user
                              : (state as UserCreated).credential.user;
                          if (user == null) {
                            return;
                          }
                          if (!user.emailVerified && (state is UserCreated)) {
                            user.sendEmailVerification();
                          }
                          if (state is UserCreated) {
                            if (user.displayName == null &&
                                user.email != null) {
                              var defaultDisplayName =
                                  user.email!.split('@')[0];
                              user.updateDisplayName(defaultDisplayName);
                            }
                          }
                          // We replace the current route with the home page
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home',
                            (_) => false,
                          );
                        }
                      },
                    ),
                  ],
                showPasswordVisibilityToggle: true,));


        default:
        return _pnf();
    }
  }

  static Route<dynamic>? _pnf() {
    print("iamhere");
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Text("Page Not Found"),
            ));
  }
  // static Route<> onPageNotFound() {

  //  }
}
