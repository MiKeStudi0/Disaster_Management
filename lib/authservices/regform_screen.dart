import 'package:disaster_management/bloc/weather_bloc_bloc.dart';
import 'package:disaster_management/screen/home_screen.dart';
import 'package:disaster_management/screen/page_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        pagemodel1(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Enter your Details',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: RegistrationForm(),
          ),
        ),
      ],
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String? _selectedGender;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(user.uid)
              .set({
            'name': _nameController.text,
            'age': _ageController.text,
            'address': _addressController.text,
            'gender': _genderController.text,
            'phoneNumber': _phoneNumberController.text,
          });
          _navigateToHomeScreen(context);
        }
      } catch (e) {
        print('Error saving user data: $e');
      }
    }
  }

  Widget _navigateToHomeScreen(BuildContext context) {
    return FutureBuilder(
        future: _determinePosition(),
        builder: (context, snap) {
          if (snap.hasData) {
            return BlocProvider<WeatherBlocBloc>(
              create: (context) =>
                  WeatherBlocBloc()..add(FetchWeather(snap.data as Position)),
              child: const HomeScreen(),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.greenAccent),
              hintStyle: TextStyle(color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _ageController,
            decoration: InputDecoration(
              labelText: 'Age',
              labelStyle: TextStyle(color: Colors.greenAccent),
              hintStyle: TextStyle(color: Colors.white),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Address',
              labelStyle: TextStyle(color: Colors.greenAccent),
              hintStyle: TextStyle(color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: _selectedGender,
            onChanged: (newValue) {
              setState(() {
                _selectedGender = newValue;
              });
            },
            decoration: InputDecoration(
              labelText: 'Gender',
              labelStyle: TextStyle(color: Colors.greenAccent),
              hintStyle: TextStyle(color: Colors.white),
            ),
            items: <String>['Male', 'Female'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your gender';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: TextStyle(color: Colors.greenAccent),
              hintStyle: TextStyle(color: Colors.red),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Submit'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}
