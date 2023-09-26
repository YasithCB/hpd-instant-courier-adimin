import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

class AcceptDelivery extends StatefulWidget {
  const AcceptDelivery({super.key, required this.delivery});

  final delivery;

  @override
  State<AcceptDelivery> createState() => _AcceptDeliveryState();
}

class _AcceptDeliveryState extends State<AcceptDelivery> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    Future<void> openMap() async {
      try {
        final pickupLocation = widget.delivery['pickLocation'];

        final coords = Coords(pickupLocation.latitude, pickupLocation.longitude);
        const title = 'Pickup Location';
        final availableMaps = await MapLauncher.installedMaps;

        // ignore: use_build_context_synchronously
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }

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
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Address : ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(widget.delivery['address']),
                        const SizedBox(height: 8),
                        const Text('Parcel  : ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(widget.delivery['parcelDesc']),
                        const SizedBox(height: 8),
                        const Text('Pick Location : ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(widget.delivery['pickLocation'].toString()),
                        const SizedBox(height: 8),
                        const Text('Drop Location : ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(widget.delivery['dropLocation'].toString()),
                        const SizedBox(height: 8),
                        const Text('Contact : ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(widget.delivery['contact']),
                        const SizedBox(height: 8),
                        const Text('Special Message : ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(widget.delivery['specialMessage']),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton.icon(
                      onPressed: openMap,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return const Color.fromARGB(255, 255, 230, 0);
                          },
                        ),
                      ),
                      icon: const Icon(
                        Icons.delivery_dining,
                      ),
                      label: Text(
                        'Accept Order',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
