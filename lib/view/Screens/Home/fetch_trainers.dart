import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, String>> fetchProfessionalData() async {
  final firestore = FirebaseFirestore.instance;

  try {
    final querySnapshot = await firestore.collection('users')
        .where('role', isEqualTo: 'Fitness Professional')
        .get();

    if (querySnapshot.docs.isEmpty) {
      return {};
    }

    final Map<String, String> fitnessProfessionals = {};

    querySnapshot.docs.forEach((doc) {
      final String name = doc['name'];
      final String uid = doc.id;
      fitnessProfessionals[name] = uid;
    });

    return fitnessProfessionals;
  } catch (e) {
    print('Error fetching Fitness Professionals: $e');
    return {};
  }
}
