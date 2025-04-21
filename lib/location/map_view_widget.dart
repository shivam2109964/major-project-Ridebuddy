import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

final locationProvider = Provider<Location>((ref) => Location());

class MapViewWidget extends ConsumerWidget {
  const MapViewWidget({super.key});

  Future<LocationData?> _getCurrentLocation(Location location) async {
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled && !await location.requestService()) return null;

    final permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied &&
        await location.requestPermission() != PermissionStatus.granted) {
      return null;
    }

    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.read(locationProvider);

    return FutureBuilder<LocationData?>(
      future: _getCurrentLocation(location),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text('Failed to get location.'));
        }

        final loc = snapshot.data!;
        final LatLng latLng = LatLng(loc.latitude!, loc.longitude!);

        return SizedBox.expand(
          // ✅ Makes it fill available space
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: latLng,
                zoom: 15,
              ),
            ),
          ),
        );
      },
    );
  }
}
