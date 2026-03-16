
import 'package:delivery_app/feature/restaurant/data/model/resturant_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/erorr/api_exception.dart';
import '../../data/model/offer_model.dart';
import '../../domain/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());


  Future<void> getOffers() async {
    emit(HomeLoading());
    try {
      final offers = await homeRepo.getOffers();
      emit(HomeSuccess(offers));
    } on ApiException catch(e){
      emit(HomeError( e.message));
    }catch(e){
      emit(HomeError( 'حدث خطأ غير متوقع'));
    }
  }




}
