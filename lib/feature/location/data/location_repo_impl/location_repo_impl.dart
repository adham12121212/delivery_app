// feature/location/data/repo/location_repo_impl.dart

import '../../../../core/service/firebase_service.dart';
import '../../../../core/service/firestore_data.dart';
import '../../domain/location_repo/location_repo.dart';
import '../model/location_model.dart';

class LocationRepoImpl implements LocationRepo {
  final FireStoreData  _firebaseService;

  LocationRepoImpl(this._firebaseService);

  @override
  Future<void> saveLocation({
    required String uid,
    required LocationModel location,
  }) async {
    await _firebaseService.setDocument(
      collection: 'user',
      docId: uid,
      subCollection: 'location',
      subDocId: 'current',
      data: location.toJson(),
    );
  }

  @override
  Future<LocationModel?> getLocation({required String uid}) async {
    final data = await _firebaseService.getDocument(
      collection: 'user',
      docId: uid,
      subCollection: 'location',
      subDocId: 'current',
    );

    if (data == null) return null;
    return LocationModel.fromJson(data);
  }
}