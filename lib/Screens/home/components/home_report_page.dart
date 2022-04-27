import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class HomeReport extends StatefulWidget {
  const HomeReport({Key? key}) : super(key: key);

  @override
  State<HomeReport> createState() => _HomeReportState();
}

class _HomeReportState extends State<HomeReport> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths!.first.extension);
      _fileName =
      _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  void _selectFolder() {
    FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => _directoryPath = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.blue,
                  ),

                ),
                Container(
                  height: MediaQuery.of(context).size.width*0.5,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/Vector.png",
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing"
                            " orci non sem aliquam rutrum in in ipsum.",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                child: const Text('Report',
                  textAlign: TextAlign.start,
                  textScaleFactor: 1.4,
                  style: TextStyle(
                    fontWeight: FontWeight.w600

                ),),
              ),
            ),

            // Container(
            //   padding: EdgeInsets.all(20),
            //   child: Row(
            //     children: [
            //       DropdownButton<FileType>(
            //           hint: const Text('LOAD PATH FROM'),
            //           value: _pickingType,
            //           items: <DropdownMenuItem<FileType>>[
            //             DropdownMenuItem(
            //               child: const Text('FROM AUDIO'),
            //               value: FileType.audio,
            //             ),
            //             DropdownMenuItem(
            //               child: const Text('FROM IMAGE'),
            //               value: FileType.image,
            //             ),
            //             DropdownMenuItem(
            //               child: const Text('FROM VIDEO'),
            //               value: FileType.video,
            //             ),
            //             DropdownMenuItem(
            //               child: const Text('FROM MEDIA'),
            //               value: FileType.media,
            //             ),
            //             DropdownMenuItem(
            //               child: const Text('FROM ANY'),
            //               value: FileType.any,
            //             ),
            //             DropdownMenuItem(
            //               child: const Text('CUSTOM FORMAT'),
            //               value: FileType.custom,
            //             ),
            //           ],
            //           onChanged: (value) => setState(() {
            //             _pickingType = value!;
            //             if (_pickingType != FileType.custom) {
            //               _controller.text = _extension = '';
            //             }
            //           })),
            //       Expanded(
            //         child: ConstrainedBox(
            //           constraints: const BoxConstraints.tightFor(width: 200.0),
            //           child: SwitchListTile.adaptive(
            //             title:
            //             Text('Multiple', textAlign: TextAlign.right),
            //             onChanged: (bool value) =>
            //                 setState(() => _multiPick = value),
            //             value: _multiPick,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       ElevatedButton(
            //         onPressed: () => _openFileExplorer(),
            //         child: const Text("Open file picker"),
            //       ),
            //       ElevatedButton(
            //         onPressed: () => _selectFolder(),
            //         child: const Text("Pick folder"),
            //       ),
            //       IconButton(
            //         onPressed: () => _clearCachedFiles(),
            //         icon:const  Icon(
            //           Icons.cleaning_services_rounded, color: Colors.blue,),

            //       ),
            //     ],
            //   ),
            // ),

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: const EdgeInsets.only(left: 8.0, top: 30, bottom: 10),
            //   child: const Text('Selected Files',
            //     textAlign: TextAlign.start,
            //     textScaleFactor: 1.1,
            //     style: TextStyle(
            //         fontWeight: FontWeight.w600

            //     ),),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.grey)
            //   ),
            //   width: MediaQuery.of(context).size.width,
            //   margin: EdgeInsets.symmetric(vertical: 5),
            //   child: Builder(
            //     builder: (BuildContext context) => _loadingPath
            //         ? Padding(
            //       padding: const EdgeInsets.only(bottom: 10.0),
            //       child: const CircularProgressIndicator(),
            //     )
            //         : _directoryPath != null
            //         ? ListTile(
            //       title: const Text('Directory path'),
            //       subtitle: Text(_directoryPath!),
            //     )
            //         : _paths != null
            //         ? Container(
            //       padding: const EdgeInsets.only(bottom: 30.0),
            //       height:
            //       MediaQuery.of(context).size.height * 0.50,
            //       child: Scrollbar(
            //           child: ListView.separated(
            //             itemCount:
            //             _paths != null && _paths!.isNotEmpty
            //                 ? _paths!.length
            //                 : 1,
            //             itemBuilder:
            //                 (BuildContext context, int index) {
            //               final bool isMultiPath =
            //                   _paths != null && _paths!.isNotEmpty;
            //               final String name = 'File $index: ' +
            //                   (isMultiPath
            //                       ? _paths!
            //                       .map((e) => e.name)
            //                       .toList()[index]
            //                       : _fileName ?? '...');
            //               final path = _paths!
            //                   .map((e) => e.path)
            //                   .toList()[index]
            //                   .toString();

            //               return ListTile(
            //                 title: Text(
            //                   name,
            //                 ),
            //                 subtitle: Text(path),
            //               );
            //             },
            //             separatorBuilder:
            //                 (BuildContext context, int index) =>
            //             const Divider(),
            //           )),
            //     )
            //         : const SizedBox(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget Cards() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      height: 40,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: 40,
            child: IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {},
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 40,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Lorem ipsum dolor sit amet",
              maxLines: 2,
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
