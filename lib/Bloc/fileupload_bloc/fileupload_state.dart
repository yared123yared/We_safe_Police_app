part of 'fileupload_bloc.dart';

abstract class FileuploadState extends Equatable {
  const FileuploadState();
  
  @override
  List<Object> get props => [];
}

class FileuploadInitial extends FileuploadState {}

class FileuploadLoading extends FileuploadState{}


class FileuploadLoaded extends FileuploadState{
  final String message;
  const FileuploadLoaded(this.message);
}

class FileuploadError extends FileuploadState{
  final String errorMessage;
  const FileuploadError(this.errorMessage);
}
