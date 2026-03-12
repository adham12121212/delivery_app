import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/feature/restaurant/domain/restaurant_repo/restaurant_reop.dart';
import 'package:meta/meta.dart';

import '../../../../core/erorr/api_exception.dart';
import '../../data/model/resturant_model.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepo restaurantRepo;
  RestaurantCubit(this.restaurantRepo) : super(RestaurantInitial());

  List<ResturantModel> allRestaurants = [];
  List<ResturantModel> _filteredRestaurants = [];

  Timer? _debounce;
  String _currentSearch = '';

  Future<void> getResturant({String? category}) async {
    emit(LoadingResturant());

    try {
      final restaurants =
      await restaurantRepo.getResturant(category: category);

      allRestaurants = restaurants;
      _filteredRestaurants = restaurants;

      emit(SuccessResturant(List.from(_filteredRestaurants)));
    } catch (e) {
      emit(ErrorResturant('حدث خطأ غير متوقع'));
    }
  }

  void filterBySearch(String search) {
    _currentSearch = search;

    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 400),
          () {

        if (_currentSearch.isEmpty) {
          _filteredRestaurants = allRestaurants;
        } else {
          _filteredRestaurants = allRestaurants.where((restaurant) {
            return restaurant.title
                .toLowerCase()
                .contains(_currentSearch.toLowerCase());
          }).toList();
        }

        emit(SuccessResturant(List.from(_filteredRestaurants)));
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
