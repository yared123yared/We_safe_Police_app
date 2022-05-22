import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Widgets/map_location.dart';


class MapDetail extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/mapdetail';
  const MapDetail({ Key? key }) : super(key: key);

  @override
  State<MapDetail> createState() => _MapDetailState();
}

class _MapDetailState extends State<MapDetail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar()
      ,
      body: MapLocaton(
        height: size.height ,
      ),
      
    );
  }
}