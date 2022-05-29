import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/case_bloc/case_bloc.dart';
import 'package:wesafepoliceapp/Bloc/fileupload_bloc/fileupload_bloc.dart';
import 'package:wesafepoliceapp/Models/case.dart';

class CaseEvidenceAdd extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/caseevidenceadd';
  const CaseEvidenceAdd({required this.caseModel, Key? key}) : super(key: key);
  final Case caseModel;

  @override
  State<CaseEvidenceAdd> createState() => CaseEvidenceAddState();
}

class CaseEvidenceAddState extends State<CaseEvidenceAdd> {
  File? imageFile;
  File? videoFile;
  File? voiceFile;
  String _description = '';

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidence'),
      ),
      body: BlocListener<CaseBloc, CaseState>(
        listener: (context, state) {
          if (state is CaseLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                  content: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: size.width - 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 40.0,
                    ),
                    Text('Loading')
                  ],
                ),
              )),
            );
          } else {
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormWrapper(
                          onPressed: () async {
                            try {
                              final _file = await _pickFile(
                                ['png', 'jpeg', 'jpg'],
                              );
                              setState(() {
                                imageFile = _file;
                              });
                            } catch (e) {
                              debugPrint("The error is ==================>");
                              debugPrint(e.toString());
                            }
                          },
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: imageFile == null
                              ? Row(
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
                                )
                              : _buildPlaceHolder(
                                  imageFile!,
                                  Image.file(
                                    imageFile!,
                                    width: 40,
                                    height: 40.0,
                                  ), () {
                                  setState(() {
                                    imageFile = null;
                                  });
                                }),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        FormWrapper(
                          padding: const EdgeInsets.all(20.0),
                          child: videoFile == null
                              ? Row(
                                  children: const [
                                    Icon(Icons.videocam),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Text(
                                      'Add Video',
                                    )
                                  ],
                                )
                              : _buildPlaceHolder(
                                  videoFile!,
                                  const Icon(
                                    Icons.movie,
                                    color: Colors.grey,
                                    size: 40.0,
                                  ), () {
                                  setState(() {
                                    videoFile = null;
                                  });
                                }),
                          onPressed: () async {
                            try {
                              File _file = await _pickFile(
                                ['mkv', 'mp4', 'avi', 'webm', 'wmv'],
                              );
                              setState(() {
                                videoFile = _file;
                              });
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        FormWrapper(
                          padding: const EdgeInsets.all(20.0),
                          child: voiceFile == null
                              ? Row(
                                  children: const [
                                    Icon(Icons.volume_up),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Text(
                                      'Add voice',
                                    )
                                  ],
                                )
                              : _buildPlaceHolder(
                                  voiceFile!,
                                  const Icon(
                                    Icons.audiotrack,
                                    color: Colors.grey,
                                    size: 40.0,
                                  ), () {
                                  setState(() {
                                    voiceFile = null;
                                  });
                                }),
                          onPressed: () async {
                            try {
                              File _file = await _pickFile(
                                ['mp3', 'ogg', 'wav', 'dsd', '3gpp'],
                              );
                              setState(() {
                                voiceFile = _file;
                              });
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          maxLines: 6,
                          minLines: 3,
                          onSaved: (value) {
                            setState(() {
                              _description = value!;
                            });
                          },
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
                      ],
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.save();
                      debugPrint('Voice file is ${voiceFile!.path}');
                      debugPrint('video file is ${videoFile!.path}');
                      debugPrint('image file is ${imageFile!.path}');
                      BlocProvider.of<CaseBloc>(context).add(UpdateCase(
                          caseModel: widget.caseModel,
                          voicePath: voiceFile!.path,
                          videoPath: videoFile!.path,
                          imagePath: imageFile!.path,
                          description: _description));
                    },
                    child: const Text('Submit'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceHolder(File _file, Widget leading, Function() onpressed) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              leading,
              const SizedBox(
                width: 30.0,
              ),
              Expanded(
                child: Text(
                  _file.path.substring(_file.path.lastIndexOf('/') + 1),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        IconButton(onPressed: onpressed, icon: const Icon(Icons.close))
      ],
    );
  }

  Future<File> _pickFile(List<String> extensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      File _file = File(file.path!);
      return _file;
    } else {
      // User canceled the picker
      throw Exception('Operation canceled');
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
