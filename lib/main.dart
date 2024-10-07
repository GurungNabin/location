import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String _address = '';

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    double latitude = 37.7749; // Example latitude
    double longitude = -122.4194; // Example longitude
    String address = await getAddressFromLatLng(latitude, longitude);
    setState(() {
      _address = address;
    });
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}, ${place.country}";
      }
    } catch (e) {
      print(e);
    }
    return "Address not found";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address Finder"),
      ),
      body: Center(
        child: Text(
          _address.isNotEmpty ? _address : "Fetching address...",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
