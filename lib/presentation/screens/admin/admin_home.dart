import 'package:flutter/material.dart';
import 'package:hpd_instant_courier_admin/presentation/screens/admin/admin_manage.dart';
import 'package:hpd_instant_courier_admin/presentation/screens/admin/rider_manage.dart';

import '../../widgets/main_drawer.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    MaterialStateProperty<Color?> getMaterialStateProperty(Color color) {
      return MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return color;
        },
      );
    }

    Future<void> setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        // await Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (ctx) => const SendParcelScreen(),
        //   ),
        // );
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
                        'Welcome {Admin name}!',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      // Text(
                      //   'Please enter your tracking number',
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .bodySmall!
                      //       .copyWith(color: Colors.white),
                      //   textAlign: TextAlign.center,
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Image.asset(
                './assets/images/home.jpg',
                height: 250,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              title: const Text('Riders Manage'),
                              subtitle: const Text(
                                'Introduce / Remove / Update delivery riders details',
                              ),
                              trailing: const Icon(Icons.delivery_dining),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RiderManageScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              title: const Text('Admins Manage'),
                              subtitle: const Text(
                                'Introduce / Remove / Update other Admins\' details',
                              ),
                              trailing: const Icon(Icons.admin_panel_settings),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AdminManageScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              title: const Text('Routes Prices'),
                              subtitle: const Text(
                                'Introduce / Remove / Update route details',
                              ),
                              trailing: const Icon(Icons.route),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const RiderManageScreen(),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ),                        
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
