import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppLayout/searchScreen/cubit/status.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/endPoint.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

import '../../../../models/SearchModel/SearchModel.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchAppInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  var searchController = TextEditingController();
  void getSearchData(inChange) {
    emit(SearchAppLoadingGetData());
    DioHelper.postData(url: SEARCH, data: {
      "text": inChange,
    }, token: token).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchHomeAppSeccessGetData());
    }).catchError((error) {
      print(error.toString());
      emit(SearchHomeAppErrorGetData());
    });
  }
}
