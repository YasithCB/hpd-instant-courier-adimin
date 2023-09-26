import 'package:cloud_firestore/cloud_firestore.dart';

class DriverRepo {
  Future<List<DocumentSnapshot>> getAllDrivers() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('riders').get();

      // The querySnapshot contains all the documents in the 'drivers' collection
      // You can access individual documents using querySnapshot.docs
      List<DocumentSnapshot> driverDocuments = querySnapshot.docs;

      return driverDocuments;
    } catch (e) {
      print("Error fetching riders: $e");
      return [];
    }
  }

  Future<DocumentSnapshot?> getDriverByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('riders')
          .where('email', isEqualTo: email) // Filter by email
          .get();

      // The querySnapshot contains all the documents in the 'riders' collection
      // that match the filter
      DocumentSnapshot driver = querySnapshot.docs.first;

      // Get the driver details from the documentSnapshot.
      Map<String, dynamic> driverDetails =
          driver.data() as Map<String, dynamic>;

      // Print the driver details
      print('Driver details: $driverDetails');

      return driver;
    } catch (e) {
      print("Error fetching riders: $e");
      return null;
    }
  }
}
