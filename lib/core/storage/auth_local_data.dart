import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AuthLocalData {
  static const _keyLoggedIn = 'logged_in';
  static const _keyUid = 'user_uid';
  static const _keyLat = 'user_lat';
  static const _keyLng = 'user_lng';
  static const _keyDistrict = 'user_district';

  /// Clear login state
  static Future<void> clearLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoggedIn);
    await prefs.remove(_keyUid);
  }

  /// Save login state
  static Future<void> saveLoginState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, value);
  }

  /// Check login state
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  /// Save UID
  static Future<void> saveUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUid, uid);
  }

  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUid);
  }

  /// Save location with optional district
  static Future<void> saveLocation(double lat, double lng, {String? district}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyLat, lat);
    await prefs.setDouble(_keyLng, lng);
    if (district != null) {
      await prefs.setString(_keyDistrict, district);
    }
  }

  /// Check if location is saved
  static Future<bool> hasLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyLat) && prefs.containsKey(_keyLng);
  }

  /// Get location
  static Future<LatLng?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_keyLat);
    final lng = prefs.getDouble(_keyLng);
    if (lat != null && lng != null) return LatLng(lat, lng);
    return null;
  }

  /// Get district
  static Future<String?> getDistrict() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDistrict);
  }
}