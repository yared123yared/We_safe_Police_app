part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}


class FetchNews extends NewsEvent{}

class FetchNewByLocation extends NewsEvent{
  
}
