import 'package:alumnest/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = StreamProvider<UserDataModel>((ref) {
  // Use authChanges to automatically handle user authentication changes
  final stream = FirebaseAuth.instance.authStateChanges().asyncExpand(
    (user) async* {
      if (user == null) {
      } else {
        // User is logged in, fetch user details
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .where('userId', isEqualTo: user.uid)
            .get(const GetOptions(
              source: Source.serverAndCache,
            ));

        if (userDoc.docs.isNotEmpty) {
          final userData = userDoc.docs.first.data();
          yield UserDataModel(
            userName: userData['name'],
            userSic: userData['sic'],
            userBranch: userData['branch'],
            userYear: userData['year'],
            userPhoneNumber: num.parse(userData['phoneNumber']),
            userEmail: userData['email'],
            userImageUrl: userData['userImage'],
            userRoles: userData['userRole'],
          );
        } else {
          // User document not found, yield an empty UserDetails
          // yield UserDetails();
          // You may need to adjust UserDetails constructor
        }
      }
    },
  );

  // Dispose the stream when the provider is disposed
  ref.onDispose(() {
    stream.drain(); // Ensure that the stream is closed
  });

  return stream;
});

// final userNameProvider = Provider<dynamic>((ref) {
//   final userDataAsyncValue = ref.watch(userDataProvider);

//   return userDataAsyncValue.map(
//     data: (userData) {
      
//     },
//     loading: (_) => 'Loading',
//     error: (_) => 'Error',
//   );
// });
