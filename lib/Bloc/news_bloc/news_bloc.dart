import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wesafepoliceapp/Models/new_model.dart';
import 'package:wesafepoliceapp/Repository/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRespository respository;
  NewsBloc({
    required this.respository,
  }) : super(NewsInitial()) {
    on<FetchNews>(_mapFetchNewsEvent);
    on<FetchNewByLocation>(_mapFetchNewsByLocation);
  }

  void _mapFetchNewsEvent(FetchNews event, Emitter<NewsState> emit) async{
    emit(NewsLoading());

    try {
      final  _response = await  respository.fetchAllNews();
      emit(NewsLoaded(_response));
      
    } catch (e) {
      emit(NewsError(e.toString()));
      
    }
  }

  void _mapFetchNewsByLocation(FetchNewByLocation event, Emitter<NewsState> emit) async{
    emit(NewsLocationLoading());

    try {
      final _response = await respository.fetchAllNewsByLocation();
      emit(NewsLocationLoaded(newsDatas: _response));
    } catch (e, stackTrace) {
      print('The stacktrace $stackTrace');
      emit(NewsLocationError(e.toString()));
    }
  }
}
