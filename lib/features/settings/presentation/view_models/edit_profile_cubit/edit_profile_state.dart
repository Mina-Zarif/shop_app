part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class GetProfileLoading extends EditProfileState {}

class GetProfileSuccess extends EditProfileState {
  final EditProfileRequest editProfileRequest;

  GetProfileSuccess(this.editProfileRequest);
}

class GetProfileFailure extends EditProfileState {
  final String errMessage;

  GetProfileFailure(this.errMessage);
}
