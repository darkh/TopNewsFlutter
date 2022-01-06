part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNews extends NewsEvent {}
