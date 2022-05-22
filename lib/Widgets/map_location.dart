import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wesafepoliceapp/Models/models.dart' as locations;
class MapLocaton extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/maplocation';
  const MapLocaton({
    required this.height,
    Key? key}) : super(key: key);
  final double height;

  @override
  State<MapLocaton> createState() => _MapLocatonState();
}

class _MapLocatonState extends State<MapLocaton> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

 Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 1.0),
      ),
    );
  }
}
