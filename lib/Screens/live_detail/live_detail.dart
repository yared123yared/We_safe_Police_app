import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wesafepoliceapp/Models/userModel.dart';
import 'package:wesafepoliceapp/Screens/home/components/call.dart';
import 'package:wesafepoliceapp/Screens/live_detail/map_detail.dart';
import 'package:wesafepoliceapp/Widgets/map_location.dart';
import 'package:wesafepoliceapp/Widgets/widgets.dart';

class LiveDetail extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/livedetail';
  final UserInfo connectedUser;
  const LiveDetail({Key? key, required this.connectedUser}) : super(key: key);

  @override
  State<LiveDetail> createState() => _LiveDetailState();
}

class _LiveDetailState extends State<LiveDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: const Text(
          'Live Detail',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Currently Watching',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: const Icon(
                      Icons.question_mark_outlined,
                      color: Colors.white,
                      size: 10.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              const LiveImage(image: "assets/images/giraffe.png", height: 200),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Current streaming location',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Stack(
                children: [
                  const MapLocaton(
                    height: 250.0,
                    latLng: LatLng(8.980603, 38.757759),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(MapDetail.routeName,
                          arguments: const LatLng(8.980603, 38.757759));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.black.withOpacity(0.3)),
                      child: const Text(
                        'view detail',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MakeCallPage(
                        onlineUser: widget.connectedUser,
                      )));
        },
        child: const Icon(Icons.phone),
      ),
    );
  }
}
