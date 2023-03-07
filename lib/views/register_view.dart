import 'package:flutter/material.dart';
import 'package:habittrackerapp/components/square_tile.dart';
import 'package:habittrackerapp/constants/routes.dart';
import 'package:habittrackerapp/utilities/show_error_snackbar.dart';
import '../components/login_textfield.dart';
import '../constants/color_palette.dart';
import '../services/auth/auth_exceptions.dart';
import '../services/auth/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    _confirmPasswordController = TextEditingController();
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

                // Text for register page
                const Text(
                  'CREATE YOUR ACCOUNT',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //  email TextField
                LoginField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 15,
                ),

                // Password Textfield
                LoginField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 15,
                ),

                // Confirm Password Textfield
                LoginField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 25,
                ),

                // Sign In Button
                TextButton(
                  onPressed: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final confirmPassword = _confirmPasswordController.text;
                    try {
                      if (password == confirmPassword) {
                        await AuthService.firebase().createUser(
                          email: email,
                          password: password,
                        );
                        AuthService.firebase().sendEmailVerification();
                        Navigator.of(context).pushNamed(verifyEmailRoute);
                      } else {
                        await showErrorSnackbar(
                          context,
                          'Passwords are not the same',
                        );
                      }
                    } on WeakPasswordAuthException {
                      await showErrorSnackbar(
                        context,
                        'Weak password',
                      );
                    } on EmailAlreadyInUseAuthException {
                      await showErrorSnackbar(
                        context,
                        'Email already in use',
                      );
                    } on InvalidEmailAuthException {
                      await showErrorSnackbar(
                        context,
                        'Invalid email',
                      );
                    } on GenericAuthException {
                      await showErrorSnackbar(
                        context,
                        'Failed to register',
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
                    'Register',
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
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: primaryColor),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Login Now',
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
