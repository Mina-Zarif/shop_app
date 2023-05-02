import 'package:dartz/dartz.dart';
import 'package:store_app/core/errors/failure.dart';
import 'package:store_app/features/home/data/models/search_model/search_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, SearchModel>> search(String text);
}
