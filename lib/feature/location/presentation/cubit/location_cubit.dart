import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/model/location_model.dart';
import '../../domain/location_repo/location_repo.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepo _repo;
  LocationCubit(this._repo) : super(LocationInitial());

  Future<void> getLocation() async {
    emit(LocationFetchLoading());
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationFetchError('خدمات الموقع معطلة. يرجى تفعيلها.'));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationFetchError('تم رفض إذن الموقع.'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationFetchError(
            'إذن الموقع مرفوض بشكل دائم. يرجى تفعيله من الإعدادات.'));
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      final latLng = LatLng(position.latitude, position.longitude);
      final district = await getDistrict(latLng);

      if (_isInsideCairo(position.latitude, position.longitude)) {
        emit(LocationFetchSuccess(latLng, district));
      } else {
        emit(LocationOutsideCairo(latLng, district));
      }
    } catch (e) {
      emit(LocationFetchError('فشل تحديد الموقع. حاول مرة أخرى.'));
    }
  }

  Future<void> saveLocation(LatLng latLng) async {
    final district = await getDistrict(latLng);
    emit(LocationSaveLoading(latLng, district));
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        emit(LocationSaveError('المستخدم غير مسجل الدخول.', latLng, district));
        return;
      }

      await _repo.saveLocation(
        uid: uid,
        location: LocationModel(lat: latLng.latitude, lng: latLng.longitude),
      );

      emit(LocationSaveSuccess());
    } catch (e) {
      emit(LocationSaveError('فشل حفظ الموقع. حاول مرة أخرى.', latLng, district));
    }
  }

  Future<String?> getDistrict(LatLng latLng) async {
    try {
      final placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isEmpty) return null;
      final placemark = placemarks.first;
      return placemark.subLocality ?? placemark.locality;
    } catch (_) {
      return null;
    }
  }

  bool _isInsideCairo(double lat, double lng) {
    const minLat = 29.95;
    const maxLat = 30.20;
    const minLng = 31.10;
    const maxLng = 31.40;
    return lat >= minLat && lat <= maxLat && lng >= minLng && lng <= maxLng;
  }
}