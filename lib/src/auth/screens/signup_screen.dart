import 'dart:io';

import 'package:alumnest/src/auth/screens/login_screen.dart';
import 'package:alumnest/src/auth/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _isAuthenticating = false;
  var _enteredpassword = '';
  var _enteredSicNumber = '';
  var _enteredbranch = '';
  var _enteredPhoneNumber = '';
  var _enteredStudentYear = '';
  var _enteredUserName = '';
  File? _selectedImage;

  bool showSecondPart = false;

  final _sicFocusNode = FocusNode();
  final _branchFocusNode = FocusNode();
  final _yearFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final InputBorder? border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  );

  Future<bool> _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return false;
    }

    if (_selectedImage == null) {
      //promt user to select a image. nessesary
      return false;
    }
    try {
      setState(() {
        _isAuthenticating = true;
      });
      await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredpassword,
      );

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child('$_enteredSicNumber.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      FirebaseFirestore.instance.collection('users').doc(_enteredSicNumber).set(
        {
          'userImage': imageUrl,
          'name': _enteredUserName,
          'sic': _enteredSicNumber,
          'branch': _enteredbranch,
          'year': _enteredStudentYear,
          'phoneNumber': _enteredPhoneNumber,
          'email': _enteredEmail,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'userRole': ['student'],
        },
      );
      return true;
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(error.message ?? 'Authenication failed'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
    return false;
  }

  @override
  void dispose() {
    _sicFocusNode.dispose();
    _branchFocusNode.dispose();
    _yearFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final shortestSide = MediaQuery.of(context).size.shortestSide < 600;
    final font15 = screenWidth * 0.038;
    final font20 = screenHeight * 0.07;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/logo-no-background.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.025,
                      top: screenHeight * 0.025,
                    ),
                    child: Text(
                      'Sign-Up',
                      style: TextStyle(
                        height: screenHeight * 0.001,
                        fontSize: font20 * 0.7,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IBMPlexMono',
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.75),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: shortestSide ? 20 : screenWidth / 5,
                    vertical: 10,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            child: !showSecondPart
                                ? buildFirstPartOfForm(context, font20, font15)
                                : buildSecondPartOfForm(
                                    context, font20, font15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFirstPartOfForm(
      BuildContext context, double font20, double font15) {
    return Form(
      key: _form,
      child: Column(
        children: [
          UserImagePicker(
            onPickImage: (pickedImage) {
              _selectedImage = pickedImage;
            },
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: border,
            ),
            initialValue: _enteredUserName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            // textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_sicFocusNode);
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (newValue) {
              _enteredUserName = newValue!;
            },
          ),
          const SizedBox(height: 7),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Sic Number',
              border: border,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: _sicFocusNode,
            textInputAction: TextInputAction.next,
            initialValue: _enteredSicNumber,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_branchFocusNode);
            },
            // textCapitalization: TextCapitalization.characters,
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length != 8) {
                return 'please enter at a valid Sic';
              }
              return null;
            },
            onSaved: (newValue) {
              _enteredSicNumber = newValue!;
            },
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Branch',
                    border: border,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                  ),
                  value: _enteredbranch.isNotEmpty ? _enteredbranch : null,
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'CSE',
                      child: Text('CSE'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'CST',
                      child: Text('CST'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'CEN',
                      child: Text('CEN'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'ECE',
                      child: Text('ECE'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'EEE',
                      child: Text('EEE'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'EIE',
                      child: Text('EIE'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _enteredbranch = value!;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a branch';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Year',
                    border: border,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: _enteredStudentYear.isNotEmpty
                      ? _enteredStudentYear
                      : null,
                  items: const [
                    DropdownMenuItem<String>(
                      value: '1st',
                      child: Text('1st'),
                    ),
                    DropdownMenuItem<String>(
                      value: '2nd',
                      child: Text('2nd'),
                    ),
                    DropdownMenuItem<String>(
                      value: '3rd',
                      child: Text('3rd'),
                    ),
                    DropdownMenuItem<String>(
                      value: '4th',
                      child: Text('4th'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _enteredStudentYear = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a year';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _form.currentState!.save();
                    setState(() {
                      showSecondPart = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: font20 * 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSecondPartOfForm(
      BuildContext context, double font20, double font15) {
    return Form(
      key: _form,
      child: Column(
        children: [
          // Widgets starting from the Year field
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: border,
            ),
            initialValue: _enteredPhoneNumber,
            keyboardType: TextInputType.number,
            focusNode: _phoneNumberFocusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length != 10) {
                return 'Please enter valid Phone number';
              }
              return null;
            },
            onSaved: (value) {
              _enteredPhoneNumber = value!;
            },
          ),
          const SizedBox(height: 7),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email Address',
              border: border,
            ),
            initialValue: _enteredEmail,
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter an email address.';
              }
              // Regular expression pattern for email validation
              final emailRegex =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address.';
              }
              // Additional check for the domain name
              if (!value.contains('@silicon.ac.in') &&
                  !value.contains('@gmail.com')) {
                return 'Please enter an email address from silicon.ac.in or gmail.com domains.';
              }
              return null;
            },
            onSaved: (value) {
              _enteredEmail = value!;
            },
          ),
          const SizedBox(height: 7),

          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              border: border,
            ),
            initialValue: _enteredpassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'password is to short';
              }
              return null;
            },
            focusNode: _passwordFocusNode,
            // onFieldSubmitted: (_) {},
            onSaved: (value) {
              _enteredpassword = value!;
            },
          ),
          const SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Expanded(
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onPressed: () {
                    _form.currentState!.save();
                    setState(() {
                      showSecondPart = false;
                    });
                  },
                  child: Text(
                    'Previous',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: font20 * 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              _isAuthenticating
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onPressed: () async {
                          _form.currentState!.save();
                          if (await _submit()) {
                            if (context.mounted) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'SignUp Successfull',
                                    ),
                                    content: const Text(
                                      'Please Sign-in with the email and password',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).popAndPushNamed(
                                              LoginScreen.routeName);
                                        },
                                        child: const Text(
                                          'Okay',
                                          style: TextStyle(
                                            // fontFamily: 'Barrbar',
                                            fontSize: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          }
                          _isAuthenticating = false;
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: font20 * 0.3,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Have an account?',
            style: TextStyle(
              height: 0.5,
              fontSize: 20,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            // style: ButtonStyle(),
            child: const Text(
              'Login instead',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
