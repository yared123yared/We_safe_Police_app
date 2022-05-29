import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wesafepoliceapp/Repository/firebase_storage.dart';

part 'fileupload_event.dart';
part 'fileupload_state.dart';

class FileuploadBloc extends Bloc<FileuploadEvent, FileuploadState> {
 final CustomFirebaseStorageClass _firebaseStorageClass = CustomFirebaseStorageClass();
  FileuploadBloc() : super(FileuploadInitial()) {
    on<UploadFile>(_mapUploadImage);
  }

  void _mapUploadImage(UploadFile event, Emitter<FileuploadState> emit) async{
    try {
      await _firebaseStorageClass.addFile(event.imagePath,event.tag);
      emit(const FileuploadLoaded('success'));
      
    } catch (e) {
      emit(FileuploadError(e.toString()));
    }
  }
}
