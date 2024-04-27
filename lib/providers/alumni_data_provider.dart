import 'package:alumnest/models/alumni_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alumniDataProvider = FutureProvider<List<AlumniDataModel>>((ref) async {
  final docRef = FirebaseFirestore.instance.collection('alumnis');
  final snapshot =
      await docRef.get(const GetOptions(source: Source.serverAndCache));

  return snapshot.docs.map((doc) {
    final data = doc.data();
    return AlumniDataModel(
      alumniName: data['name'],
      alumniSic: data['sic'],
      alumniBranch: data['branch'],
      alumniBatch: data['batch'],
      alumniCompanyName: data['companyName'],
      alumniPositionInCompany: data['positionInCompany'],
      alumniLinkedInId: data['LinkedInId'],
      alumniEmail: data['email'],
      alumniImageUrl: data['userImageUrl'],
    );
  }).toList();
});
