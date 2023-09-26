import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryRepo {
  Future<List<dynamic>> getAllDelivers() async {
    final delivers =
        await FirebaseFirestore.instance.collection('delivers').get();
    return delivers.docs.map((doc) => doc.data()).toList();
  }
}
