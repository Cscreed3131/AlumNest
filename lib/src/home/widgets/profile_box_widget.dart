import 'package:alumnest/src/auth/screens/login_screen.dart';
import 'package:alumnest/src/home/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileDialogBox extends StatefulWidget {
  const ProfileDialogBox({super.key});

  @override
  State<ProfileDialogBox> createState() => _ProfileDialogBoxState();
}

class _ProfileDialogBoxState extends State<ProfileDialogBox> {
  @override
  Widget build(BuildContext context) {
    // final userRole = ref.watch(userRoleProvider) ?? ['student'];
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              insetPadding: EdgeInsets.zero,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  const Center(
                    child: Text(
                      'AlumNest',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'IBMPlexMono',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        // color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (userRole.contains('administrator'))
                  //   ListTile(
                  //     onTap: () => {
                  //       Navigator.of(context)
                  //           .popAndPushNamed(AdminHomeScreen.routeName),
                  //     },
                  //     leading: const Icon(Icons.admin_panel_settings),
                  //     title: const Text('Adminstrator'),
                  //   ),
                  // ListTile(
                  //   onTap: () => {
                  //     // Navigator.of(context)
                  //     //     .popAndPushNamed(OrderHistoryScreen.routeName),
                  //   },
                  //   leading: const Icon(Icons.history_rounded),
                  //   title: const Text('Order history'),
                  // ),
                  ListTile(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(ProfileScreen.routeName),
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                  ),
                  ListTile(
                    onTap: () => {},
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                  ),
                  const AboutListTile(
                    icon: Icon(Icons.info_rounded),
                    applicationName: 'AlumNest',
                    applicationVersion: '1.0.0',
                    applicationLegalese: '© 2023 Cliff',
                    aboutBoxChildren: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "©AlumNest is enables you to connect with your alumni and get to know about their experiences and get guidance from them.",
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    child: Text(
                      "about",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.exit_to_app_rounded,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onTap: () {
                      try {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Alert',
                              ),
                              content: const Text(
                                'Are you sure you want to Sign-out',
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontFamily: 'IBMPlexMono',
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    try {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      FirebaseAuth.instance
                                          .signOut()
                                          // .then((_) =>
                                          //     ref.invalidate(userDataProvider))
                                          .then((value) => Navigator.of(context)
                                              .popAndPushNamed(
                                                  LoginScreen.routeName));
                                    } on FirebaseAuthException catch (_) {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Unable to logout.'),
                                        ),
                                      );
                                      // You might want to show a dialog or a snackbar with the error message here
                                    }
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      fontFamily: 'IBMPlexMono',
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } on FirebaseAuthException catch (error) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              error.message ??
                                  'You ran into an unexpected error',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // this will be a textbutton.
                      Text(
                        'Privacy Policy',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const CircleAvatar(
                        radius: 1,
                        foregroundColor: Colors.grey,
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      // this will also be a textbutton.
                      Text(
                        'Terms of Service',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.account_circle,
        // color: Colors.black87,
        size: 30,
      ),
    );
  }
}
