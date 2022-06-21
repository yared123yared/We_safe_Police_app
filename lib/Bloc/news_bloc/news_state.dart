part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
  
  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}


class NewsLoading extends NewsState{}
class NewsLocationLoading extends NewsState{}

class NewsLoaded extends NewsState{
  final List<NewsModel> newsDatas;
  const NewsLoaded(this.newsDatas);
}



class NewsLocationLoaded extends NewsState{
  final List<NewsModel> newsDatas;
  const NewsLocationLoaded({
    required this.newsDatas
  });
}


class NewsError extends NewsState{
  final String errorMessage;
  const NewsError(this.errorMessage);
}

class NewsLocationError extends NewsState{
  final String errorMessage;
  const NewsLocationError(this.errorMessage);
}

