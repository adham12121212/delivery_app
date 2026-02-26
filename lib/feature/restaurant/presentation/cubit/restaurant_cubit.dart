import 'package:bloc/bloc.dart';
import 'package:delivery_app/feature/restaurant/domain/restaurant_repo/restaurant_reop.dart';
import 'package:meta/meta.dart';

import '../../../../core/erorr/api_exception.dart';
import '../../data/model/resturant_model.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepo restaurantRepo;
  RestaurantCubit(this.restaurantRepo) : super(RestaurantInitial());


  Future<void> getResturant({String? category}) async {
    emit(LoadingResturant());
    try {
      final restaurants = await restaurantRepo.getResturant(category: category);
      emit(SuccessResturant(restaurants));
    } on ApiException catch (e) {
      emit(ErrorResturant(e.message));
    } catch (e) {
      emit(ErrorResturant('حدث خطأ غير متوقع'));
    }
  }
}
