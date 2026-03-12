// feature/location/data/model/location_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final double lat;
  final double lng;

  const LocationModel({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
    'savedAt': FieldValue.serverTimestamp(),
  };

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );
}