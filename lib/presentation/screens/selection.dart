import 'package:flutter/material.dart';

import 'auth.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/home.jpg',
                height: 300,
              ),
            ),
            const SizedBox(height: 80),
            Text(
              'Continue as',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 60,
              width: 350,
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: getMaterialStateProperty(primaryColor),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(isAdmin: false),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delivery_dining,
                  color: Colors.white,
                ),
                label: Text(
                  'Rider',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: 350,
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: getMaterialStateProperty(primaryColor),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(isAdmin: true),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                ),
                label: Text(
                  'Admin',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
