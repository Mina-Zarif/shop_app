import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/core/errors/failure.dart';
import 'package:store_app/core/utils/api_service.dart';
import 'package:store_app/features/settings/data/models/edit_profile_models/edit_profile_request.dart';
import 'package:store_app/features/settings/data/repos/edit_profile_repo/edit_profile_repo.dart';

class EditProfileRepoImpl implements EditProfileRepo {
  final ApiService _apiService;

  EditProfileRepoImpl(this._apiService);

  @override
  Future<Either<Failure, EditProfileRequest>> editProfile(
      {required String name,
      required String email,
      required String phone}) async {
    try {
      var data = await _apiService.get(
          endpoint: kUpdateProfile,
          token: token,
          data: {"name": name, "email": email, "phone": phone});
      return Right(EditProfileRequest.fromJson(data));
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, EditProfileRequest>> fetchProfileData() async {
    try {
      var data =
          await _apiService.get(endpoint: kProfileEndpoint, token: token);
      return Right(EditProfileRequest.fromJson(data));
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}
