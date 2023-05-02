import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/features/settings/data/models/edit_profile_models/edit_profile_request.dart';
import 'package:store_app/features/settings/data/repos/edit_profile_repo/edit_profile_repo_impl.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.editProfileRepoImpl) : super(EditProfileInitial());
  final EditProfileRepoImpl editProfileRepoImpl;

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    var response = await editProfileRepoImpl.fetchProfileData();
    response.fold((failure) {
      emit(GetProfileFailure(failure.errMessage));
    },(response) {
      if (false) {
        emit(GetProfileFailure('error'));
      } else {
        emit(GetProfileSuccess(response));
      }
    });
  }
}
