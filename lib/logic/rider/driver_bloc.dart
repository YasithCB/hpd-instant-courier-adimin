import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hpd_instant_courier_admin/data/models/rider_model.dart';
import 'package:hpd_instant_courier_admin/data/repositories/driver_repo.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  List<Map<String, dynamic>> _drivers = [];
  final DriverRepo _driverRepo = DriverRepo();

  DriverBloc() : super(DriverInitial());

  @override
  Stream<DriverState> mapEventToState(DriverEvent event) async* {
    if (event is FetchDrivers) {
      try {
        // Fetch the drivers from Firestore
        final riders = await _driverRepo.getAllDrivers();

        // Convert DocumentSnapshots to Map<String, dynamic>
        final drivers = riders
            .map((snapshot) => snapshot.data() as Map<String, dynamic>)
            .toList();

        yield DriverLoaded(
            drivers); // Emit DriverLoaded state with the list of drivers
      } catch (e) {
        yield DriverError(e.toString());
      }
    }
  }

  List<Map<String, dynamic>> get allDrivers => _drivers;

  // Define a method to fetch rider data
  Future<void> fetchRiderData() async {
    try {
      // Fetch rider data from your data source (e.g., Firestore)
      final riders = await _driverRepo.getAllDrivers();

      // Convert DocumentSnapshots to Map<String, dynamic>
      final drivers = riders
          .map((snapshot) => snapshot.data() as Map<String, dynamic>)
          .toList();

      // Update the list of drivers
      _drivers = drivers;
    } catch (e) {
      // Handle errors as needed
    }
  }

  Future<Driver?> getDriverById(String driverId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('drivers')
              .doc(driverId)
              .get();

      if (snapshot.exists) {
        final Map<String, dynamic> driverData = snapshot.data()!;
        final Driver driver = Driver(
          id: driverData['id'],
          name: driverData['name'],
          email: driverData['email'],
          phoneNumber: driverData['phoneNumber'],
          address: driverData['address'],
          currentLocation: driverData['currentLocation'],
        );

        return driver;
      } else {
        // Driver with the given ID does not exist
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the database query
      print('Error fetching driver data: $e');
      return null;
    }
  }
}

class DriverError extends DriverState {
  final String error;

  DriverError(this.error);
}

class DriverLoaded extends DriverState {
  final List<Map<String, dynamic>> driversData;

  DriverLoaded(this.driversData);
}

// Define a DriverEvent class
abstract class DriverEvent {}

// Create a specific event class, for example, FetchDrivers
class FetchDrivers extends DriverEvent {
  // You can include any necessary properties or methods here
}

class DriverState {
  // Define the properties and methods of the DriverState class
}

// Define your DriverInitial state class
class DriverInitial extends DriverState {
  // Add any necessary properties or methods for the initial state
}
