import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sheikh_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SheikhModel>> fetchSheikhs() async {
    final snapshot = await _firestore.collection('sheikhs').get();
    return snapshot.docs
        .map((d) => SheikhModel.fromDoc(d.id, d.data()))
        .toList();
  }

  Future<SheikhModel> fetchSheikhById(String id) async {
    final doc = await _firestore.collection('sheikhs').doc(id).get();
    return SheikhModel.fromDoc(doc.id, doc.data()!);
  }
}
