import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/pages/frame_page.dart';
import 'package:helloworld/pages/login_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Se l'utente è loggato
          if (snapshot.hasData) {
            return const FramePage();
          }
          // Se l'utente non è loggato
          else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
