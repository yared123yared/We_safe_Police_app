part of 'useralert_bloc.dart';

abstract class UseralertEvent extends Equatable {
  const UseralertEvent();

  @override
  List<Object> get props => [];
}


class GetUserALert extends UseralertEvent{}