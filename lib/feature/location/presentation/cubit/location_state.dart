import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationState {
  LatLng? get latLng => null;
}

// ── Fetch States ─────────────────────────────────
class LocationInitial extends LocationState {}

class LocationFetchLoading extends LocationState {}

class LocationFetchSuccess extends LocationState {
  final LatLng latLng;
  final String? district;
  LocationFetchSuccess(this.latLng, this.district);
}

class LocationFetchError extends LocationState {
  final String message;
  LocationFetchError(this.message);
}

class LocationOutsideCairo extends LocationState {
  final LatLng latLng;
  final String? district;
  LocationOutsideCairo(this.latLng, this.district);
}

// ── Save States ─────────────────────────────────
class LocationSaveLoading extends LocationState {
  final LatLng latLng;
  final String? district;
  LocationSaveLoading(this.latLng, this.district);
}

class LocationSaveSuccess extends LocationState {}

class LocationSaveError extends LocationState {
  final String message;
  final LatLng latLng;
  final String? district;
  LocationSaveError(this.message, this.latLng, this.district);
}