import 'package:bloc/bloc.dart';
import 'package:delivery_app/feature/menu/data/model/menu_model.dart';
import 'package:delivery_app/feature/menu/domain/menu_repo/menu_repo.dart';
import 'package:meta/meta.dart';

import '../../../../core/erorr/api_exception.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuRepo menuRepo;
  MenuCubit(this.menuRepo) : super(MenuInitial());

  int _page = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  Future<void> getMenu(String restaurantId) async {
    emit(LoadingMenu());

    try {
      final result = await menuRepo.getMenu(restaurantId);
      final categories = result
          .where((item) => item.isAvailable && item.menuCategory.trim().isNotEmpty)
          .map((item) => item.menuCategory.trim())
          .toSet()
          .toList();
      emit(SuccessMenu(result, categories));
    } catch (e) {
      emit(ErrorMenu(e.toString()));
    }
  }





}
