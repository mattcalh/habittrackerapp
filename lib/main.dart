import 'package:flutter/material.dart';
import 'package:habittrackerapp/services/auth/auth_service.dart';
import 'package:habittrackerapp/views/login_view.dart';
import 'package:habittrackerapp/views/main_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:habittrackerapp/views/profile_view.dart';
import 'package:habittrackerapp/views/register_view.dart';
import 'package:habittrackerapp/views/settings_view.dart';
import 'package:habittrackerapp/views/verify_email_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'constants/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox("Habit_Database");

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        mainRoute: (context) => const MainView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        profileRoute: (context) => ProfileView(),
        settingsRoute: (context) => const SettingsView(),
      },
      theme: ThemeData(primarySwatch: Colors.red),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const MainView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
