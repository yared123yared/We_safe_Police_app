import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CaseEvidenceAdd extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/caseevidenceadd';
  const CaseEvidenceAdd({Key? key}) : super(key: key);

  @override
  State<CaseEvidenceAdd> createState() => CaseEvidenceAddState();
}

class CaseEvidenceAddState extends State<CaseEvidenceAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidence'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopWidget(),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Evidence',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              FormWrapper(
                onPressed: () async {
                  _pickFile(
                    ['png', 'jpeg', 'jpg'],
                  );
                },
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.add_a_photo,
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      'Add Photo',
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              FormWrapper(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: const [
                    Icon(Icons.videocam),
                    SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      'Add Video',
                    )
                  ],
                ),
                onPressed: () async {
                  _pickFile(
                    ['mkv', 'mp4', 'avi', 'webm', 'wmv'],
                  );
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              FormWrapper(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: const [
                    Icon(Icons.volume_up),
                    SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      'Add voice',
                    )
                  ],
                ),
                onPressed: () {
                  _pickFile(
                    ['mp3', 'ogg', 'wav', 'dsd'],
                  );
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                maxLines: 6,
                minLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // _pickFile();
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _pickFile(List<String> extensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      // User canceled the picker
    }
  }

  Widget _buildTopWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: const [
          Icon(
            Icons.balance,
            size: 80,
            color: Colors.white,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam eleifend lorem vitae turpis dictum, non dictum mauris feugiat''',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class FormWrapper extends StatelessWidget {
  const FormWrapper({
    Key? key,
    required this.child,
    this.padding,
    required this.onPressed,
  }) : super(key: key);
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey,
              )),
          child: child),
    );
  }
}
