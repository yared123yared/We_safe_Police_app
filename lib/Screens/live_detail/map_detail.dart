import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wesafepoliceapp/Widgets/map_location.dart';


class MapDetail extends StatelessWidget {
  static const routeName = 'wesafepoliceapp/mapdetail';
  const MapDetail({
    required this.latLng,
     Key? key }) : super(key: key);
  final LatLng latLng;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar()
      ,
      body: MapLocaton(
        latLng: latLng,
        
        height: size.height ,

      ),
      
    );
  }
}


// class MapDetail extends StatefulWidget {
//   static const routeName = 'wesafepoliceapp/mapdetail';
//   const MapDetail({
    
//      Key? key }) : super(key: key);
//   final LatLng latLng;

//   @override
//   State<MapDetail> createState() => _MapDetailState();
// }

// class _MapDetailState extends State<MapDetail> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar()
//       ,
//       body: MapLocaton(
//         latLng: widget.latLng,
//         height: size.height ,
//       ),
      
//     );
//   }
// }