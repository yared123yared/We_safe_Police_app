// ignore_for_file: sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wesafepoliceapp/Bloc/investigation_bloc/investigation_bloc.dart';
import 'package:wesafepoliceapp/Screens/case_detail/case_evidence_add.dart';

class SearchImage extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/searchimage';
  const SearchImage({Key? key}) : super(key: key);

  @override
  State<SearchImage> createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('search image'),
        centerTitle: true,
      ),
      body: BlocBuilder<InvestigationBloc, InvestigationState>(
        builder: (context, state) {
          debugPrint('The investigation state is $state');
          return Container(
            width: size.width,
            padding: const EdgeInsets.all(20.0),
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
                              'Choose Photo',
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
                ElevatedButton.icon(
                  onPressed: () {
                    BlocProvider.of<InvestigationBloc>(context).add(
                      SearchImageEvent(
                        imageFile
                        
                      )
                    );
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                ),
          
                const SizedBox(height: 30.0,),
                if(state is InvestigationLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
                 if(state is InvestigationLoaded)
                  SizedBox(
                    height: size.height * 0.5,
                    child: ListView(
                      children: state.images.map((image) => Container(
                        height: 200,
                        child: Image.network(
                          image,
                          
                        )
                        )).toList(),
                    ),
                  ),
                
                if(state is InvestigationError)
                 Text(state.errorMessage.toString(), style: const TextStyle(color: Colors.red),),
          
              ],
            ),
          );
        },
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
        IconButton(
          onPressed: onpressed,
          icon: const Icon(Icons.close),
        )
      ],
    );
  }

  Future<File> _pickFile(List<String> extensions) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _imageFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (_imageFile != null) {
      File _file = File(_imageFile.path);
      return _file;
    } else {
      // User canceled the picker
      throw Exception('Operation canceled');
    }
  }
}
