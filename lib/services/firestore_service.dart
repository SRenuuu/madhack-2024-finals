import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<T>> getDocuments<T>(
      Function fromJson,
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
    List<Object?> res = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(res);

    // Manually convert each map to the desired type T
    List<T> convertedRes = [];
    for (var item in res) {
      print("====");
      print(item);
      convertedRes.add(fromJson(item));
    }

    print(convertedRes);

    return convertedRes;
  }
}
