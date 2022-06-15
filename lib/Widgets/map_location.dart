import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wesafepoliceapp/Models/models.dart' as locations;
class MapLocaton extends StatefulWidget {

  static const routeName = 'wesafepoliceapp/maplocation';
  const MapLocaton({
    required this.height,
    required  this.latLng,
    Key? key}) : super(key: key);
  final double height;
  
  final LatLng latLng;

  @override
  State<MapLocaton> createState() => _MapLocatonState();
}

class _MapLocatonState extends State<MapLocaton> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;
  late  LatLng _center;
  String _currentAddress = '';
  late CameraPosition _initialLocation;
  Position _currentPosition = Position(
    longitude: 0, 
    latitude: 0, 
    timestamp: DateTime.now(), 
    accuracy: 0.0, 
    altitude: 0.0, 
    heading: 0.0, 
    speed: 0.0, 
    speedAccuracy: 0.0,
    );
  @override
  void initState() {

    super.initState();
    _getCurrentLocation();
    setState(() {
      // const LatLng(8.980603, 38.757759);
      _center =   widget.latLng;
     _initialLocation =  CameraPosition(target: widget.latLng);
      
    });
  }

  
  final Set<Marker> _markersSet =  {};

 Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: _center,
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
        _markersSet.add(marker);
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('<====================================================== Marker =================================>');
    // debugPrint(_markersSet.toString());
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            markers: _markersSet,
            initialCameraPosition: CameraPosition(target: _center, zoom: 13.0),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: _buildMyLocationButton(() {
              mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
              
            }),
          )
        ],
      ),
    );
  }

  // Method for retrieving the current location

_getCurrentLocation() async {
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) async {
    setState(() {
      // Store the position in the variable
      _currentPosition = position;

      print('CURRENT POS: $_currentPosition');

      // For moving the camera to current location
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
    });
    await _getAddress();
  }).catchError((e) {
    print(e);
  });
}
// Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        // startAddressController.text = _currentAddress;
        // _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildMyLocationButton(Function() onPressed,){
    return ClipOval(
  child: Material(
    color: Colors.orange.shade100, // button color
    child: InkWell(
      splashColor: Colors.orange, // inkwell color
      child: const SizedBox(
        width: 56,
        height: 56,
        child: Icon(Icons.my_location),
      ),
      onTap: onPressed,
    ),
  ),
);

  }
}
