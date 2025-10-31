import 'package:equatable/equatable.dart';

class AppSettingsState extends Equatable {
  final bool darkMode;
  final bool twoFactorAuth;
  final String language;
  final bool notificationsEnabled;
  final bool locationEnabled;

  const AppSettingsState({
    this.darkMode = false,
    this.twoFactorAuth = false,
    this.language = 'English',
    this.notificationsEnabled = true,
    this.locationEnabled = true,
  });

  AppSettingsState copyWith({
    bool? darkMode,
    bool? twoFactorAuth,
    String? language,
    bool? notificationsEnabled,
    bool? locationEnabled,
  }) {
    return AppSettingsState(
      darkMode: darkMode ?? this.darkMode,
      twoFactorAuth: twoFactorAuth ?? this.twoFactorAuth,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      locationEnabled: locationEnabled ?? this.locationEnabled,
    );
  }

  @override
  List<Object?> get props => [
        darkMode,
        twoFactorAuth,
        language,
        notificationsEnabled,
        locationEnabled,
      ];

  Map<String, dynamic> toJson() {
    return {
      'darkMode': darkMode,
      'twoFactorAuth': twoFactorAuth,
      'language': language,
      'notificationsEnabled': notificationsEnabled,
      'locationEnabled': locationEnabled,
    };
  }

  factory AppSettingsState.fromJson(Map<String, dynamic> json) {
    return AppSettingsState(
      darkMode: json['darkMode'] ?? false,
      twoFactorAuth: json['twoFactorAuth'] ?? false,
      language: json['language'] ?? 'English',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      locationEnabled: json['locationEnabled'] ?? true,
    );
  }
}
