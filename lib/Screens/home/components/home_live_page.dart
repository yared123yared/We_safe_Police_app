import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signalr_client/signalr_client.dart';
import 'package:wesafepoliceapp/Models/userModel.dart';
import 'package:wesafepoliceapp/Screens/screens.dart';
import 'package:wesafepoliceapp/Widgets/widgets.dart';

class HomeLive extends StatefulWidget {
  const HomeLive({Key? key}) : super(key: key);

  @override
  State<HomeLive> createState() => _HomeLiveState();
}

class _HomeLiveState extends State<HomeLive> {
   List<UserInfo> connectedUser = [];
   final serverUrl = 'http://192.168.124.127:5088/test';
  late HubConnection hubConnection;
  final List<String> _images = [
    "assets/images/giraffe.png",
    'assets/images/contact_img.png',
    "assets/images/giraffe.png",
    "assets/images/wallpaper.png"
  ];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSignalR();
    //  eventBus.on<WebebRtcSignalReceivedEvent>().listen((event) {
    //     if (event.webRTCMessage.type == "offer") {
    //       _showAnswerCallDialog(event.webRTCMessage);
    //     }
    //   });
    // hubConnection.on('SendSignal', _handleSendSignal);
  }
   Future<void> initSignalR() async {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.onclose((error) => print("Connection Close"));
    //  hubConnection.onclose((e);
    hubConnection.on('NewUserArrived', _handlenewUser);
  }
  _handlenewUser(List<Object> arguments) {
    print("New User is arrived with object ${arguments[0]}");
    Map<String, dynamic> user = jsonDecode(arguments[0].toString());
    UserInfo userInfo = UserInfo.fromJson(user);
    print("User Info after parse: ${userInfo}");
    setState(() {
      connectedUser = connectedUser..add(userInfo);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Currently Live',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: connectedUser.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap:(){
                      Navigator.of(context).pushNamed(LiveDetail.routeName, arguments: const LatLng(8.980603, 38.757759));
                    },
                    child: Column(
                      children: [
                        Text(connectedUser[index].userName.toString(), style:const TextStyle(
                          color: Colors.green
                        ),),
                        const SizedBox(height: 3,),
                        LiveImage(
                          image: _images[index],
                          height: 250,
                        ),
                      ],
                    )
                  );
                })
          ],
        ));
  }
}
