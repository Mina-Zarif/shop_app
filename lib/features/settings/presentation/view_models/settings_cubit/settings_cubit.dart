import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/core/models/user_data_models/user_data_response.dart';
import 'package:store_app/features/settings/data/repos/settings_repo/settings_repo_impl.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepoImpl) : super(SettingsInitial());

  final SettingsRepoImpl _settingsRepoImpl;



  Future<void> logout() async {
    emit(LogOutSuccess());
    var response = await _settingsRepoImpl.logout();
    response.fold((failure) {
      emit(LogOutFailure(failure.errMessage));
    }, (data) {
      if (data.status == false) {
        emit(LogOutFailure(data.message!));
      } else {
        emit(LogOutSuccess());
      }
    });
  }
}
