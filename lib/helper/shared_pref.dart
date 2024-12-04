import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Keys for all variables
  static const String keyIsApplicationInProgress = 'isApplicationInProgress';
  static const String keyCurrentStage = 'currentStage';

  // Getter and Setter for IsApplicationInProgress
  static bool get isApplicationInProgress =>
      _preferences?.getBool(keyIsApplicationInProgress) ?? false;

  static Future<void> setIsApplicationInProgress(bool value) async {
    await _preferences?.setBool(keyIsApplicationInProgress, value);
  }

  // Getter and Setter for CurrentStage
  static int get currentStage => _preferences?.getInt(keyCurrentStage) ?? 0;

  static Future<void> setCurrentStage(int value) async {
    await _preferences?.setInt(keyCurrentStage, value);
  }
}
