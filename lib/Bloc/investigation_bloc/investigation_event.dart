part of 'investigation_bloc.dart';

abstract class InvestigationEvent extends Equatable {
  const InvestigationEvent();

  @override
  List<Object> get props => [];
}



class SearchImageEvent extends InvestigationEvent {
  final File? image;
  const SearchImageEvent(this.image);
}