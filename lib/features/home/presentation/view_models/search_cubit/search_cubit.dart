import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:store_app/features/home/data/models/search_model/datum.dart';
import 'package:store_app/features/home/data/models/search_model/search_model.dart';
import 'package:store_app/features/home/data/repos/search_repo/search_repo_impl.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepoImpl) : super(SearchInitial());

  final SearchRepoImpl searchRepoImpl;
  void getSearch(String text) async {
    emit(SearchLoading());
    var result = await searchRepoImpl.search(text);
    result.fold((failure) {
      emit(SearchError(failure.errMessage));
    }, (response) {
      if (response.status == true) {
        emit(SearchSuccess(response));
      } else {
        emit(SearchError('error'));
      }
    });
  }
}
