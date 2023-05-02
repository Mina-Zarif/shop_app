import 'package:dartz/dartz.dart';
import 'package:store_app/core/errors/failure.dart';
import 'package:store_app/features/settings/data/models/edit_profile_models/edit_profile_request.dart';
import 'package:store_app/features/settings/data/repos/edit_profile_repo/edit_profile_repo_impl.dart';

abstract class EditProfileRepo {
  Future<Either<Failure, EditProfileRequest>> editProfile({
    required String name,
    required String email,
    required String phone,
  });

  Future<Either<Failure, EditProfileRequest>> fetchProfileData();
}
