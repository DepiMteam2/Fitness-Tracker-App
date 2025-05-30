import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/src/screens/home_screen.dart';
import 'package:fitness_app/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot){
            if(snapshot.hasData) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }),
      ),
    );
  }
}
