import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences{
  static SharedPreferences? _preferences;
  static const String deviceType = "deviceType";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setDeviceTypeIsIPD(bool value) async {
    await _preferences?.setBool(deviceType, value);
  }

  static bool? getDeviceTypeIsIPD() => _preferences?.getBool(deviceType);
}