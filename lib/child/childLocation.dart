import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';





class ChildLocation extends StatefulWidget {
  const ChildLocation({Key? key}) : super(key: key);

  @override
  State<ChildLocation> createState() => _ChildLocationState();
}

class _ChildLocationState extends State<ChildLocation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  late  CameraPosition _kGooglePlex =CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(33.00612304357525, -7.61903647333561),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  void getCurrentLocation() async{

    LocationPermission permission = await Geolocator.checkPermission();
    Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print('current position is ${currentPosition.latitude.toString()}');
    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 14.4746,
      );
    });

  }
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
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
          Marker(markerId: MarkerId('source'),position: _kGooglePlex.target)
        },
      ),

    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
}
