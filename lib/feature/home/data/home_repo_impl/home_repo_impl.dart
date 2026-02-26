import 'package:delivery_app/feature/restaurant/data/model/resturant_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/erorr/api_exception.dart';
import '../../../../core/erorr/firebase_auth_error_mapper.dart';
import '../../../../core/service/firestore_data.dart';
import '../../domain/home_repo/home_repo.dart';
import '../model/offer_model.dart';

class HomeRepoImpl implements HomeRepo {
  final FireStoreData fireStoreData;

  HomeRepoImpl(this.fireStoreData);

  @override
  Future<List<OfferModel>> getOffers() async {
    try {
      final data = await fireStoreData.getOffer();
      return data;
    }  on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('حدث خطأ غير متوقع');
    }
  }


}
