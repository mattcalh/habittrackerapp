// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:habittrackerapp/components/square_tile.dart';
import 'package:habittrackerapp/services/auth/auth_third_parties.dart';
import '../components/login_textfield.dart';
import '../constants/color_palette.dart';
import '../constants/routes.dart';
import '../services/auth/auth_exceptions.dart';
import '../services/auth/auth_service.dart';

import '../utilities/show_error_snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),

                // Logo
                const Icon(
                  Icons.abc_rounded,
                  size: 100,
                ),

                // Welcome Text for login page
                const Text(
                  'Welcome Back to ABC',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // Password Textfiel
                LoginField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 15,
                ),

                // Password Textfiel
                LoginField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10,
                ),

                // Forgot Password message
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // Sign In Button
                TextButton(
                  onPressed: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    try {
                      await AuthService.firebase().logIn(
                        email: email,
                        password: password,
                      );
                      final user = AuthService.firebase().currentUser;
                      if (user?.isEmailVerified ?? false) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          mainRoute,
                          (route) => false,
                        );
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          verifyEmailRoute,
                          (route) => false,
                        );
                      }
                    } on UserNotFoundAuthException {
                      await showErrorSnackbar(
                        context,
                        'User not found',
                      );
                    } on WrongPasswordAuthException {
                      await showErrorSnackbar(
                        context,
                        'Wrong credentials',
                      );
                    } on GenericAuthException {
                      await showErrorSnackbar(
                        context,
                        'Authentification error',
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 100),
                      foregroundColor: backgroundColor,
                      backgroundColor: primaryColor,
                      shape: const StadiumBorder()),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                // Text for more log in options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: primaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                // Other ways to register/log-in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      onTap: () => ThirdParties().signInWihtGoogle(),
                      imagePath: 'lib/images/google-logo.png',
                    ),

                    const SizedBox(
                      width: 25,
                    ),

                    // apple logo
                    SquareTile(
                      onTap: () {},
                      imagePath: 'lib/images/apple-logo.png',
                    ),

                    const SizedBox(
                      width: 25,
                    ),

                    // apple logo
                    SquareTile(
                      onTap: () {},
                      imagePath: 'lib/images/facebook-logo.png',
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                // If not a member, regsiter here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(color: primaryColor),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
