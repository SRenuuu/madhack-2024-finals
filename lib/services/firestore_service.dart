import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<T>> getDocuments<T>(
      Function fromDocument,
      String collectionName,
      Map<String, dynamic>? filter,
      Query Function(Query query)? orderBy,
      ) async {
    Query query = _firestore.collection(collectionName);

    if (filter!= null) {
      filter.forEach((key, value) {
        query = query.where(key, isEqualTo: value);
      });
    }

    if (orderBy!= null) {
      query = orderBy(query);
    }

    final querySnapshot = await query.get();

    print(querySnapshot.docs);

    List<T> convertedRes = [];
    for (var doc in querySnapshot.docs) {
      convertedRes.add(fromDocument(doc));
    }

    return convertedRes;
  }
}
