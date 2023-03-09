// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../constants/color_palette.dart';
import '../constants/routes.dart';
import '../services/auth/auth_service.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            mainRoute,
            (route) => false,
          );
        },
        child: const Icon(Icons.event),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: primaryColor,
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
      body: const Center(
          child: Text(
        'Settings',
        style: TextStyle(
          color: primaryColor,
          fontSize: 58,
          fontWeight: FontWeight.bold,
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        notchMargin: 10,
        // make rounded corners & create a notch for the floating action button
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(1)),
          ),
          StadiumBorder(),
        ),
        child: IconTheme(
          data: const IconThemeData(color: backgroundColor, size: 36),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Menu button
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 25),

                // Search Button
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Settings button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 25),

                      // Profile button
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            profileRoute,
                            (route) => false,
                          );
                        },
                        icon: const Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
