import 'package:flutter/material.dart';
import 'package:hpd_instant_courier_admin/logic/rider/driver_bloc.dart';

class AdminManageScreen extends StatefulWidget {
  const AdminManageScreen({Key? key}) : super(key: key);

  @override
  State<AdminManageScreen> createState() => _AdminManageScreenState();
}

class _AdminManageScreenState extends State<AdminManageScreen> {
  final DriverBloc _riderBloc = DriverBloc();
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phoneNumber = '';
  String address = '';

  @override
  void dispose() {
    // _riderBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Fetch rider details when the screen is loaded.
    _fetchAdminDetails();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _fetchAdminDetails() async {
    // await _riderBloc.fetchRiderData();
  }

  Future<void> _saveNewRider() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     await _riderBloc
  //         .saveNewRider(
  //           name: name,
  //           email: email,
  //           phoneNumber: phoneNumber,
  //           address: address,
  //           // Add other necessary rider data fields here if needed.
  //         )
  //         .then((isSaved) => isSaved
  //             ? showSnackBar('Admin Saved Succesffull!')
  //             : showSnackBar('Error while saving! Please Try again'));

  //     // Clear the form after saving the new rider.
  //     _formKey.currentState!.reset();
  //   } else {
  //     showSnackBar('Fill all required fields!');
  //   }
  }

  @override
  Widget build(BuildContext context) {
    Widget newRiderForm = Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            onSaved: (value) {
              name = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            onSaved: (value) {
              email = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Phone Number'),
            onSaved: (value) {
              phoneNumber = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a phone number';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Address'),
            onSaved: (value) {
              address = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // _saveNewRider();
              });
            },
            child: const Text('Save New Admin'),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Manage'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                newRiderForm,
                const SizedBox(height: 20),
                // StreamBuilder<List<Map<String, dynamic>>>(
                //   stream: _riderBloc.riderStream,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       // Display rider details fetched from the bloc.
                //       List<Map<String, dynamic>> riderData = snapshot.data!;
                //       return Column(
                //         children: [
                //           Text(
                //             'Current Admins',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .titleMedium!
                //                 .copyWith(fontWeight: FontWeight.bold),
                //           ),
                //           for (var rider in riderData)
                //             ListTile(
                //               title: Text(
                //                 'Name: ${rider['name']}',
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .bodyMedium!
                //                     .copyWith(fontWeight: FontWeight.bold),
                //               ),
                //               subtitle: Row(
                //                 children: [
                //                   Text('Email: ${rider['email']}'),
                //                   const SizedBox(width: 20),
                //                   Text('Address: ${rider['address']}'),
                //                   const SizedBox(width: 20),
                //                   Text('Contact: ${rider['phoneNumber']}'),
                //                 ],
                //               ),
                //               // Add other rider details here if needed.
                //             ),
                //         ],
                //       );
                //     } else if (snapshot.hasError) {
                //       return const Text('Error fetching Admins details');
                //     } else if (snapshot.data == null ||
                //         snapshot.data!.isEmpty) {
                //       return const Center(child: Text('No Admins Yet!'));
                //     } else {
                //       return const CircularProgressIndicator();
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
