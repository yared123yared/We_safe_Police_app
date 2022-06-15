import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';



class CustomVideoPlayer extends StatefulWidget {
  static const routeName = 'wesafepolicescoreapp/customvideoplayer';
  final String url;
  const CustomVideoPlayer({ 
    required this.url,
    Key? key }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  // late VideoPlayerController _playerController;
  late FlickManager flickmanager;

  @override
  void initState() {
    
    super.initState();
    flickmanager = FlickManager(
      videoPlayerController:  VideoPlayerController.network(
      widget.url,
      closedCaptionFile: _loadCaptions()
    ),
    

      );
   
  }
Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('assets/images/test_file.srt');
    flickmanager.flickControlManager!.toggleSubtitle();
    return SubRipCaptionFile(fileContents);
  }
  @override
  void dispose() {
    flickmanager.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    
    return VisibilityDetector(
        key: ObjectKey(flickmanager),
        onVisibilityChanged: (visibility){
          if (visibility.visibleFraction == 0 && this.mounted) {
          flickmanager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickmanager.flickControlManager?.autoResume();
        }
        },
        child: Container(
        child: FlickVideoPlayer(
          flickManager: flickmanager,
          flickVideoWithControls: const FlickVideoWithControls(
            closedCaptionTextStyle: TextStyle(fontSize: 8),
            controls: FlickPortraitControls(),
          ),
          flickVideoWithControlsFullscreen: const FlickVideoWithControls(
            controls: FlickLandscapeControls(),
          ),
        ),
      ),

      
    );
  }
}