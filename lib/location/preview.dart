import 'package:flutter/material.dart';
import 'package:ridebuddy/location/map_view_widget.dart';

class MapPreview extends StatefulWidget {
  const MapPreview({super.key});

  @override
  State<MapPreview> createState() => _MapPreview();
}

class _MapPreview extends State<MapPreview> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: MapViewWidget(),
      )),
    );
  }
}
