import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'app_settings_state.dart';

class AppSettingsCubit extends HydratedCubit<AppSettingsState> {
  AppSettingsCubit() : super(const AppSettingsState());

  void toggleDarkMode() {
    emit(state.copyWith(darkMode: !state.darkMode));
  }

  void toggleTwoFactorAuth() {
    emit(state.copyWith(twoFactorAuth: !state.twoFactorAuth));
  }

  void setLanguage(String language) {
    emit(state.copyWith(language: language));
  }

  void toggleNotifications() {
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
  }

  void toggleLocation() {
    emit(state.copyWith(locationEnabled: !state.locationEnabled));
  }

  void setDarkMode(bool value) {
    emit(state.copyWith(darkMode: value));
  }

  void setTwoFactorAuth(bool value) {
    emit(state.copyWith(twoFactorAuth: value));
  }

  void setNotifications(bool value) {
    emit(state.copyWith(notificationsEnabled: value));
  }

  void setLocation(bool value) {
    emit(state.copyWith(locationEnabled: value));
  }

  void resetToDefaults() {
    emit(const AppSettingsState());
  }

  @override
  AppSettingsState? fromJson(Map<String, dynamic> json) {
    try {
      return AppSettingsState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AppSettingsState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
