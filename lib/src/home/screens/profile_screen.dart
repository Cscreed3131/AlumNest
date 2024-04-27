import 'package:alumnest/global_variables.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: appBarTextSyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/cool_image.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Card(
                        child: TextFormField(
                          decoration: formInputDecoration('Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Card(
                        child: TextFormField(
                          decoration: formInputDecoration('Sic'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your SIC';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Card(
                        child: TextFormField(
                          decoration: formInputDecoration('Branch'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your branch';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Card(
                        child: TextFormField(
                          decoration: formInputDecoration('Batch'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your batch year';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Card(
                        child: TextFormField(
                          decoration: formInputDecoration('Company Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your company name';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Card(
                        child: TextFormField(
                          decoration:
                              formInputDecoration('Position in Company'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your position in company';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Card(
                        child: TextFormField(
                          decoration: formInputDecoration('LinkedInId'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your LinkedIn ID';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Card(
                        child: TextFormField(
                          decoration: formInputDecoration('Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Card(
                        child: TextFormField(
                          decoration:
                              formInputDecoration('Role in Current Company'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your role in current company';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
