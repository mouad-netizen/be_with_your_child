import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';





class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  late  CameraPosition _kGooglePlex =CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(33.00213057181679, -7.618672472680941),
      tilt: 59.440717697143555,
      zoom: 13.151926040649414);

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(33.00612304357525, -7.61903647333561),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(markerId: MarkerId('source'),position: _kGooglePlex.target, infoWindow: InfoWindow(
            title: 'You',
          ),),
          Marker(markerId: MarkerId('destination'),position: _kLake.target ,infoWindow: InfoWindow(
      title: 'your child',
      ),),
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To my child'),
        icon: const Icon(Icons.person),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
