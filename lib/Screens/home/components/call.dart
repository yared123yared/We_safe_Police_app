import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:hello_world/app_store/app_state.dart';
import 'dart:core';
import 'package:http/http.dart';
import 'package:signalr_client/signalr_client.dart';
import 'package:wesafepoliceapp/Models/userModel.dart';
import 'package:wesafepoliceapp/Screens/home/components/webRtcEvent.dart';




class MakeCallPage extends StatefulWidget {
  final UserInfo onlineUser;
  const MakeCallPage({required this.onlineUser});
  @override
  State<StatefulWidget> createState() {
    return new _MakeCallState();
  }
}

class _MakeCallState extends State<MakeCallPage> {
  late MediaStream _localStream;
  String token = "";
  late UserInfo onlineUser; //this the user being called
  late RTCPeerConnection pc;
  late HubConnection hubConnection;
  final serverUrl = 'http://192.168.124.127:5088/test';
  //  Video rendering
  final RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();

  bool _inCalling = false;
  @override
  void initState() {
    super.initState();
    // eventBus.on<WebebRtcSignalReceivedEvent>().listen((event) {
    //   if (event.webRTCMessage.type == "answer") {
    //     log("Handling webrtc answer");
    //     _handleAnswer(event);
    //   }
    //   if (event.webRTCMessage.type == "candidate") {
    //     _handleIceCandidate(event);
    //   }
    // });
    onlineUser = widget.onlineUser;
    // _userLoginDetails =
    //     Provider.of<AppState>(context, listen: false).getUserLoginDetails();
    // token = _userLoginDetails.accessToken;
    initSignalR();
    initRenderers();
  }

  Future<void> initSignalR() async {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.onclose((error) => print("Connection Close"));
    //  hubConnection.onclose((e);
    // hubConnection.on('NewUserArrived', _handlenewUser);
  }

  @override
  deactivate() {
    super.deactivate();
    if (_inCalling) {
      _hangUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P2P Call'),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: null,
            tooltip: 'setup',
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
              child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: RTCVideoView(_remoteRenderer),
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 3,
                child: Container(
                  child: RTCVideoView(_localRenderer),
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
            ],
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inCalling ? _hangUp : _makeCall,
        tooltip: _inCalling ? 'Hangup' : 'Call',
        child: Icon(_inCalling ? Icons.call_end : Icons.phone),
      ),
    );
  }

  _hangUp() async {
    try {
      await _localStream.dispose();
      _remoteRenderer.srcObject = null;
      _localRenderer.srcObject = null;
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _inCalling = false;
    });
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  _makeCall() async {
    final Map<String, dynamic> mediaConstraints = {
      "audio": true,
      "video": {
        "mandatory": {
          "minWidth":
              '640', // Provide your own width, height and frame rate here
          "minHeight": '480',
          "minFrameRate": '30',
        },
        "facingMode": "user",
        "optional": [],
      }
    };
final Map<String, dynamic> mediaConstraints2 = {
      "audio": true,
      "video": {
        "mandatory": {
          "minWidth":
              '640', // Provide your own width, height and frame rate here
          "minHeight": '480',
          "minFrameRate": '30',
        },
        "facingMode": "environment",
        "optional": [],
      }
    };
    try {
      var stream = await navigator.getUserMedia(mediaConstraints);
      var stream2 = await navigator.getUserMedia(mediaConstraints2);
      _localStream = stream;
      _localRenderer.srcObject = _localStream;
      //Todo remove remote renderer here, video will come from somewhere
      _remoteRenderer.srcObject = stream2;
      await _createPeerConnection(stream);
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    setState(() {
      _inCalling = true;
    });
  }

  sendToServer(Map<String, Object> data) async {
    // print("making sendToServer call");
    // post("$kHostUrl/api/chats/web-rtc-signal",
    //         headers: {
    //           "Content-Type": "application/json",
    //           "Authorization": "Bearer $token"
    //         },
    //         body: jsonEncode(data))
    //     .then((response) {});
    // WebRTCMessage webRTCMessage = WebRTCMessage.fromJson(data);
    print("Send server method invocked");
    await hubConnection.invoke('StartCall', args: <Object>[onlineUser.connectionId.toString()]);
    print("sent to the server");
  }

  _handleAnswer(WebebRtcSignalReceivedEvent event) async {
    await pc.setRemoteDescription(RTCSessionDescription(
        event.webRTCMessage.sdp["sdp"], event.webRTCMessage.sdp["type"]));
  }

  _handleIceCandidate(WebebRtcSignalReceivedEvent event) async {
    var candidate = RTCIceCandidate(
        event.webRTCMessage.candidate["candidate"],
        event.webRTCMessage.candidate["sdpMid"],
        int.parse(event.webRTCMessage.candidate["sdpMLineIndex"]));
    await pc.addCandidate(candidate);
  }

  _createPeerConnection(dynamic stream) async {
    print("Creating peer connection");
    pc = await createPeerConnection(_iceServers, _config);
    pc.addStream(_localStream);

    pc.onIceCandidate = (candidate) {
      if (candidate.candidate != null) {
        sendToServer({
          "type": "candidate",
          'to': onlineUser.connectionId.toString(), //set to userId here
          "from": 123,
          'candidate': {
            'sdpMLineIndex': candidate.sdpMLineIndex,
            'sdpMid': candidate.sdpMid,
            'candidate': candidate.candidate,
          },
        });
      }
    };
    pc.onIceConnectionState = (state) {};

    pc.onAddStream = (stream) {
      _remoteRenderer.srcObject = stream;
    };
    pc.onRemoveStream = (stream) {
      // if (this.onRemoveRemoteStream != null) this.onRemoveRemoteStream(stream);
      // _remoteStreams.removeWhere((it) {
      // return (it.id == stream.id);
      // });
    };

    pc.onDataChannel = (channel) {
      // _addDataChannel(id, channel);
    };
    var localDescription = await pc.createOffer(_constraints);
    await pc.setLocalDescription(localDescription);
    sendToServer({
      "to": onlineUser.connectionId.toString(),
      "from": 123,
      "sdp": {
        'type': localDescription.type,
        'sdp': localDescription.sdp,
      },
      "type": "offer"
    });

    // pc.onAddTrack = (stream, track) {
    //   _remoteRenderer.srcObject = stream;
    // };

    return pc;
  }

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {"url": "stun:stun.l.google.com:19302"},
    ]
  };
  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };
  final Map<String, dynamic> _constraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': [],
  };
}
