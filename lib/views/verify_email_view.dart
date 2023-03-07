// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:habittrackerapp/constants/color_palette.dart';
import 'package:habittrackerapp/constants/routes.dart';
import 'package:habittrackerapp/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: primaryColor,
      ),
      body: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 75,
                ),
                const Icon(
                  Icons.mark_email_unread,
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'We\'ve sent you a verification email. Please open it to verify your account.',
                  style: TextStyle(
                    fontSize: 22,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'If you haven\'nt receive a verification email yet, press the button below.',
                  style: TextStyle(
                    fontSize: 22,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 50,
                ),

                // Send Email Verification Button
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().sendEmailVerification();
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 100),
                      foregroundColor: backgroundColor,
                      backgroundColor: primaryColor,
                      shape: const StadiumBorder()),
                  child: const Text(
                    'Send Email Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                // Restart button
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => false,
                    );
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 100),
                      foregroundColor: backgroundColor,
                      backgroundColor: primaryColor,
                      shape: const StadiumBorder()),
                  child: const Text(
                    'Restart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
