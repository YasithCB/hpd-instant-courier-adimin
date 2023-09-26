import 'package:flutter/material.dart';
import 'package:hpd_instant_courier_admin/logic/rider/accepted_delivery.dart';
import 'package:hpd_instant_courier_admin/presentation/util.dart';

class AvilableDeliveryCard extends StatelessWidget {
  const AvilableDeliveryCard({super.key, required this.delivery});

  final delivery;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Function to show the confirmation dialog
    Future<void> showConfirmationDialog(
        BuildContext context, Map<String, dynamic> delivery) async {
      bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Acceptance'),
            content:
                const Text('Are you sure you want to accept this delivery?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pop(false), // Return false when canceled
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  acceptedDeliveryBloc.setAcceptedDelivery(delivery);
                  Navigator.pop(context);
                  showSnackBar(
                      context, 'You accepted this delivery successfully!');
                }, // Return true when accepted
                child: const Text('Accept'),
              ),
            ],
          );
        },
      );

      if (confirm == true) {
        // Handle the accepted delivery logic here
        // For example, update the delivery status or perform other actions
      }
    }

    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.red),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From : ${delivery['from']}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To : ${delivery['to']}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Parcel Description :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    delivery['parcelDesc'],
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: getMaterialStateProperty(primaryColor),
                      foregroundColor: getMaterialStateProperty(Colors.white)),
                  onPressed: () {
                    showConfirmationDialog(context, delivery);
                  },
                  child: const Text('Accept'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: getMaterialStateProperty(Colors.red),
                      foregroundColor: getMaterialStateProperty(Colors.white)),
                  onPressed: () {},
                  child: const Text('Decline'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
