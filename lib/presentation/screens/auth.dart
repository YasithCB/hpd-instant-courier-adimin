import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hpd_instant_courier_admin/data/repositories/driver_repo.dart';
import 'package:hpd_instant_courier_admin/presentation/screens/admin/admin_home.dart';
import 'package:hpd_instant_courier_admin/presentation/screens/rider/rider_home.dart';
import 'package:hpd_instant_courier_admin/presentation/util.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.isAdmin});

  final bool isAdmin;

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  DriverRepo driverRepo = DriverRepo();

  final _form = GlobalKey<FormState>();
  bool _isAdmin = false;
  var _enteredEmail = '';
  var _enteredPassword = '';

  bool _isAuthenticating = false;

  @override
  void initState() {
    _isAdmin = widget.isAdmin;
    super.initState();
  }

  void _submit() async {
    var driver = driverRepo.getDriverByEmail(_enteredEmail);

    if (driver != null) {
      print(_enteredEmail);
      print(driver);
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => _isAdmin ? const AdminHomeScreen() : const RiderHomeScreen(),
    //   ),
    // );
  }

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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                width: 300,
                child: Image.asset('assets/images/home.jpg'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onChanged: (newValue) {
                              _enteredEmail = newValue;
                              print(_enteredEmail);
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            SizedBox(
                              height: 50,
                              width: 350,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      getMaterialStateProperty(primaryColor),
                                ),
                                onPressed: _submit,
                                child: Text(
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
