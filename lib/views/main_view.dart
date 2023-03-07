import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittrackerapp/services/auth/auth_service.dart';

import '../constants/routes.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text(
          'LOGGED IN AS: ${user.email!}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
