import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittrackerapp/components/login_button.dart';
import 'package:habittrackerapp/components/square_tile.dart';
import '../components/login_textfield.dart';
import '../constants/color_palette.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      // Wrong Email
      if (e.code == 'user-not-found') {
        print('no user found for that email');
      }
      // WRONG Password
      else if (e.code == 'wrong-password') {
        print('Wrong password');
      }
    }

    // Delete loading sign
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
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
                'Welcome Back to the Login Page of ABC',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // Username textfield
              LoginField(
                controller: _usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(
                height: 15,
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
              LoginButton(
                onTap: signUserIn,
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
                children: const [
                  // google button
                  SquareTile(imagePath: 'lib/images/google-logo.png'),

                  SizedBox(
                    width: 25,
                  ),

                  // apple logo
                  SquareTile(imagePath: 'lib/images/apple-logo.png'),

                  SizedBox(
                    width: 25,
                  ),

                  // apple logo
                  SquareTile(imagePath: 'lib/images/facebook-logo.png'),
                ],
              ),

              const SizedBox(
                height: 50,
              ),

              // If not a member, regsiter here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: primaryColor),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Register Now',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
