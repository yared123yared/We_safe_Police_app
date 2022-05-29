part of 'fileupload_bloc.dart';



abstract class FileuploadEvent extends Equatable {
  const FileuploadEvent();

  @override
  List<Object> get props => [];
}

class UploadFile extends FileuploadEvent{
  final String imagePath;
  final String tag;
  const UploadFile({
    required this.imagePath,
    required this.tag
  });
}
