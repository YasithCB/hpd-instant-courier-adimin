import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hpd_instant_courier_admin/data/models/rider_model.dart';
import 'package:hpd_instant_courier_admin/data/repositories/delivery_repo.dart';
import 'package:hpd_instant_courier_admin/logic/rider/accepted_delivery.dart';
import 'package:hpd_instant_courier_admin/logic/rider/driver_bloc.dart';
import 'package:hpd_instant_courier_admin/presentation/screens/rider/accept_delivery.dart';
import 'package:location/location.dart';

import '../../widgets/main_drawer.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  final DriverBloc _driverBloc = DriverBloc();
  final DeliveryRepo _deliveryRepo = DeliveryRepo();
  List allDriversList = [];
  List<dynamic> allDeliveries = [];

  late LocationData locationData;

  @override
  void initState() {
    super.initState();
    fetchDrivers();
    fetchDeliveries();
    updateDriverLocation();
  }

  void fetchDeliveries() {
    _deliveryRepo.getAllDelivers().then((deliveries) {
      setState(() {
        allDeliveries = deliveries;
      });
    });
  }

  Future<void> fetchDrivers() async {
    await _driverBloc.fetchRiderData();
    allDriversList = _driverBloc.allDrivers;
    print(allDriversList);
  }

  void getLocation() async {
    // Initialize location plugin
    final Location location = Location();

    // Request permission to access location
    await location.requestPermission();

    // Get the current location
    locationData = await location.getLocation();
  }

  void updateDriverLocation() {
    getLocation();
    // Create a timer to update driver locations every 5 seconds
    Timer timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      try {
        // Fetch driver locations from your data source (e.g., Firestore)
        final currentDriver =
            await _driverBloc.getDriverById('9IcTe9REJjstDc6vgBop');

        // Update the driver locations in your app's state or database
        // updateDriverLocations(driverLocations);
      } catch (e) {
        print('Error updating driver locations: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    Map<String, dynamic> acceptedDelivery;
    List<Driver> allDriversList = [];

    Future<void> setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {}
    }

    Widget availableDeliveries = Column(
      children: [
        Text(
          'Available Deliveries',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: primaryColor, fontWeight: FontWeight.bold, fontSize: 22),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 450,
            child: Expanded(
              child: ListView.builder(
                itemCount: allDeliveries.length,
                itemBuilder: (context, index) {
                  final delivery = allDeliveries[index];
                  return Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Address : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text(delivery['address']),
                                const Text('Parcel  : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text(delivery['parcelDesc']),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AcceptDelivery(delivery: delivery),
                                ),
                              );
                            },
                            child: const Text('Accept'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HPD instant courier",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.apps,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: MainDrawer(onSelectScreen: setScreen),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
                child: Container(
                  color: primaryColor,
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Welcome {Rider name}!',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Image.asset(
                './assets/images/home.jpg',
                height: 200,
              ),
              const SizedBox(height: 15),
              StreamBuilder<Map<String, dynamic>>(
                stream: acceptedDeliveryBloc.acceptedDeliveryStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    acceptedDelivery = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 15),
                      child: Column(
                        children: [
                          Text(
                            'Accepted Delivery Details',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return availableDeliveries;
                  }
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
