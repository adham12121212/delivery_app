
// feature/location/data/repo/location_repo.dart

import '../../data/model/location_model.dart';

abstract class LocationRepo {
  Future<void> saveLocation({
    required String uid,
    required LocationModel location,
  });

  Future<LocationModel?> getLocation({required String uid});
}