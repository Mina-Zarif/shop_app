part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String errMessage;

  SearchError(this.errMessage);
}

class SearchSuccess extends SearchState {
  final SearchModel searchModel;

  SearchSuccess(this.searchModel);
}
