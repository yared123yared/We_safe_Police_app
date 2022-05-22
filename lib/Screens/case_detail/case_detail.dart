import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Models/case.dart';
import 'package:wesafepoliceapp/Utils/utils.dart';

class CaseDetail extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/caseDetail';
  const CaseDetail({required this.policeCase, Key? key}) : super(key: key);
  final Case policeCase;

  @override
  State<CaseDetail> createState() => _CaseDetailState();
}

class _CaseDetailState extends State<CaseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                        widget.policeCase.openedDate.toString(),
                        style: kDateTimeTextStyle,
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.done_all_outlined,
                    color: Colors.blue,
                    size: 25,
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  Row(
                    children: const [
                      Text('Attachment'),
                      Icon(
                        Icons.file_present,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildImageAndVideos(Icons.videocam, 'Video'),
                      const SizedBox(
                        width: 10.0,
                      ),
                      _buildImageAndVideos(Icons.photo_library, 'Photo'),
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  _buildAudio()
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageAndVideos(IconData iconData, String title) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade400,
        ),
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(
              iconData,
              color: Colors.white,
              size: 40.0,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAudio() {
    return Container(
      width: double.infinity,
      height: 40.0,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.black
        )
      ),
      child: Row(
        children: [
          
        ],
      ),
    );
  }
}
