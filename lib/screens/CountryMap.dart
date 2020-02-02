import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CountryMap extends StatelessWidget {
  static const routeName = '/country-map';

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final Map country = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(country['name']),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(country['latlng'][0], country['latlng'][1]),
          zoom: 5,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
