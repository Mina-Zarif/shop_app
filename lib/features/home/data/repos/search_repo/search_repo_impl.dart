import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/core/errors/failure.dart';
import 'package:store_app/core/utils/api_service.dart';
import 'package:store_app/features/home/data/models/search_model/search_model.dart';
import 'package:store_app/features/home/data/repos/search_repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final ApiService _apiService;

  SearchRepoImpl(this._apiService);

  @override
  Future<Either<Failure, SearchModel>> search(String text) async {
    try {
      var data =
          await _apiService.get(endpoint: kSearchEndpoint, token: token, query: {
        "text": text,
      });
      return Right(SearchModel.fromJson(data));
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}
