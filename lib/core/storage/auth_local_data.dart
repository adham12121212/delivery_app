import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AuthLocalData {
  static const _keyLoggedIn = 'logged_in';
  static const _keyLat = 'user_lat';
  static const _keyLng = 'user_lng';

  static Future<void> saveLoginState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  static Future<void> saveLocation(double lat, double lng) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyLat, lat);
    await prefs.setDouble(_keyLng, lng);
  }

  static Future<bool> hasLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyLat) && prefs.containsKey(_keyLng);
  }

  static Future<LatLng?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_keyLat);
    final lng = prefs.getDouble(_keyLng);
    if (lat != null && lng != null) {
      return LatLng(lat, lng);
    }
    return null;
  }
}