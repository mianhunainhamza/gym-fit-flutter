import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, String>> fetchProfessionalData() async {
  final firestore = FirebaseFirestore.instance;

  try {
    final querySnapshot = await firestore
        .collection('users')
        .where('role', isEqualTo: 'Fitness Professional')
        .get();

    if (querySnapshot.docs.isEmpty) {
      return {};
    }

    final Map<String, String> fitnessProfessionals = {};

    for (var doc in querySnapshot.docs) {
      final String name = doc['name'];
      final String uid = doc.id;
      final String profilePicUrl = doc['profilePicUrl'];
      fitnessProfessionals[name] = profilePicUrl;
      print("uid: $uid");
      // fitnessProfessionals[profilePicUrl] = profilePicUrl;
    }
    print("fitnessProfessionals: $fitnessProfessionals");
    return fitnessProfessionals;
  } catch (e) {
    print('Error fetching Fitness Professionals: $e');
    return {};
  }
}
