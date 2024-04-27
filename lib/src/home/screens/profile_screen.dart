import 'package:alumnest/global_variables.dart';
import 'package:alumnest/providers/user_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  void _submit(
    String userName,
    String userSic,
    String userBranch,
    String userEmail,
    String imageUrl,
    num userPhoneNumber,
  ) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final collectionReference =
        FirebaseFirestore.instance.collection('alumnis');
    collectionReference.doc(userSic).set({
      'name': userName,
      'sic': userSic,
      'branch': userBranch,
      'batch': batchController.text,
      'companyName': companyNameController.text,
      'positionInCompany': positionInCompanyController.text,
      'LinkedInId': linkedInIdController.text,
      'email': userEmail,
      'userImageUrl': imageUrl,
      'userPhoneNumber': userPhoneNumber,
    });
  }

  final _formKey = GlobalKey<FormState>();
  final batchController = TextEditingController();
  final companyNameController = TextEditingController();
  final positionInCompanyController = TextEditingController();
  final linkedInIdController = TextEditingController();

  @override
  void dispose() {
    batchController.dispose();
    companyNameController.dispose();
    positionInCompanyController.dispose();
    linkedInIdController.dispose();
    super.dispose();
  }

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
          child: ref.watch(userDataProvider).when(
            data: (data) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          data.userImageUrl,
                        ),
                        fit: BoxFit.cover,
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
                            // controller: nameController,
                            enabled: false,
                            initialValue: data.userName,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            // controller: sicController,
                            enabled: false,
                            initialValue: data.userSic,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            // controller: branchController,
                            enabled: false,
                            initialValue: data.userBranch,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            controller: batchController,

                            // initialValue: ,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: formInputDecoration('Batch'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your batch';
                              }
                              return null;
                            },
                          ),
                        ),
                        // const SizedBox(height: 10),
                        Card(
                          child: TextFormField(
                            controller: companyNameController,

                            // initialValue: data.userSic,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: formInputDecoration('Company Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your company name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            controller: positionInCompanyController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                        Card(
                          child: TextFormField(
                            controller: linkedInIdController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: formInputDecoration('LinkedInId'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your LinkedIn ID';
                              }
                              return null;
                            },
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            // controller: emailController,
                            enabled: false,
                            initialValue: data.userEmail,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: formInputDecoration('Email'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _submit(
                              data.userName,
                              data.userSic,
                              data.userBranch,
                              data.userEmail,
                              data.userImageUrl,
                              data.userPhoneNumber,
                            );
                            Navigator.of(context).pop();
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
            error: (error, stackTrace) {
              return const Center(
                child: Text('Encountered an unexpected error try angain later'),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
        ),
      ),
    );
  }
}
