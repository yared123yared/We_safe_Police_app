import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Models/case.dart';
import 'package:wesafepoliceapp/Screens/case_detail/case_evidence_add.dart';
import 'package:wesafepoliceapp/Utils/utils.dart';
import 'package:wesafepoliceapp/Widgets/cached_custome_network_image.dart';
import 'package:wesafepoliceapp/Widgets/image_viewer_widget.dart';
import 'package:wesafepoliceapp/Widgets/video_player_widget.dart';
import 'package:just_audio/just_audio.dart';

class CaseDetail extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/caseDetail';
  const CaseDetail({required this.policeCase, Key? key}) : super(key: key);
  final Case policeCase;

  @override
  State<CaseDetail> createState() => _CaseDetailState();
}

class _CaseDetailState extends State<CaseDetail> {
  final _audioPlayer = AudioPlayer();
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CaseEvidenceAdd.routeName,
                    arguments: widget.policeCase);
              },
              icon: const Icon(
                Icons.add_box_outlined,
                color: Colors.black,
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.policeCase.summary!,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormaterClass.formatDate(
                                widget.policeCase.openedDate.toString()),
                            style: kDateTimeTextStyle,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.done_all_outlined,
                      color: Colors.blue,
                      size: 25,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  Row(
                    children: const [
                      Text('Videos'),
                      Icon(
                        Icons.video_call,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  _buildVideos(widget.policeCase.evidence!.attachment!.videos!),
                  Row(
                    children: const [
                      Text('Images'),
                      Icon(
                        Icons.image,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  _buildImage(widget.policeCase.evidence!.attachment!.images!),
                   const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: const [
                      Text('Voices'),
                      Icon(
                        Icons.mic,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                   const SizedBox(
                    height: 10.0,
                  ),
                  _buildAudio(widget.policeCase.evidence!.attachment!.voices!),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _buildDescription(widget.policeCase.description.toString())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideos(List<Media> data) {
    return SizedBox(
        height: 200,
        width: double.infinity,
        child: CarouselSlider(
            options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {}),
            items: data.map((media) {
              return Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(CustomVideoPlayer.routeName,
                        arguments: media.url);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Stack(children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: CustomCachedNetworkImage(
                            url: media.url.toString(),
                            borderRadius: BorderRadius.circular(10.0),
                            placeholder:
                                'assets/images/police_image_three.jpeg',
                            boxFit: BoxFit.fill,
                            width: double.infinity,
                            height: 250),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 60.0,
                        ),
                      )
                    ]),
                  ),
                );
              });
            }).toList()));
  }

  Widget _buildImage(List<Media> data) {
    return SizedBox(
        height: 200,
        width: double.infinity,
        child: CarouselSlider(
            options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {}),
            items: data.map((media) {
              return Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ImageViewerWidget.routeName,
                        arguments: media.url);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Stack(children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: CustomCachedNetworkImage(
                            url: media.url.toString(),
                            borderRadius: BorderRadius.circular(10.0),
                            placeholder: 'assets/images/police_image_one.jpg',
                            boxFit: BoxFit.fill,
                            width: double.infinity,
                            height: 250),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ]),
                  ),
                );
              });
            }).toList()));
  }

  Widget _buildAudio(List<Media> data) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 40.0,
        autoPlay: false,
        viewportFraction: 1,
        onPageChanged: (index, reason) {},
      ),
      items: data
          .map((media) => Builder(
              builder: ((context) => Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async{
                                await _audioPlayer.setVolume(1.0);

                              },
                              icon: const Icon(
                                Icons.volume_up,
                                color: Colors.black,
                              ),
                            ),
                            const Text('Play audio')
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                               setState(() {
                                
                              });
                              if(_audioPlayer.playing){
                                await _audioPlayer.pause();
                              }else{
                                await _audioPlayer.setUrl(media.url!, preload: false);
                                await _audioPlayer.load();
                                await _audioPlayer.play();
                              }
                             
                            },
                            icon:  Icon(
                              _audioPlayer.playing? Icons.play_arrow: Icons.pause,
                              color: Colors.pink,
                            ))
                      ],
                    ),
                  ))))
          .toList(),
    );
  }

  Widget _buildDescription(String description) {
    return Column(
      children: [
        SizedBox(
          height: 30.0,
          child: Row(children: const [
            VerticalDivider(
              color: Colors.blue,
              thickness: 3.0,
            ),
            Expanded(
              child: Text(
                'Description',
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(description)
      ],
    );
  }
}
