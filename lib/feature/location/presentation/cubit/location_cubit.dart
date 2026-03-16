import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import '../../data/model/location_model.dart';
import '../../domain/location_repo/location_repo.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepo repo;

  LocationCubit(this.repo) : super(LocationInitial());

  /// جلب موقع المستخدم الحالي
  Future<void> getLocation() async {
    emit(LocationFetchLoading());

    try {
      // التأكد أن الخدمة مفعلة
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationFetchError('خدمات الموقع معطلة. يرجى تفعيلها.'));
        return;
      }

      // التأكد من الإذن
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        emit(LocationFetchError('تم رفض إذن الموقع.'));
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        emit(LocationFetchError(
            'إذن الموقع مرفوض بشكل دائم. يرجى تفعيله من الإعدادات.'));
        return;
      }

      // جلب الموقع الحالي
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final latLng = LatLng(position.latitude, position.longitude);

      // جلب district فقط
      final district = await getDistrict(latLng);

      if (district != null && district.isNotEmpty) {
        emit(LocationFetchSuccess(latLng, district));
      } else {
        emit(LocationFetchError(
            'لم نستطع تحديد المنطقة بدقة. حاول مرة أخرى.'));
      }
    } catch (e) {
      emit(LocationFetchError('فشل تحديد الموقع. حاول مرة أخرى.'));
    }
  }

  /// حفظ الموقع في الريبو
  Future<void> saveLocation({
    required String uid,
    required LatLng latLng,
  }) async {
    final district = await getDistrict(latLng);
    emit(LocationSaveLoading(latLng, district));

    try {
      await repo.saveLocation(
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
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isEmpty) return null;

      final placemark = placemarks.first;

      return placemark.subLocality ??
          placemark.locality ??
          placemark.name;
    } catch (e) {
      return null;
    }
  }
}