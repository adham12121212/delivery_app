import 'package:delivery_app/feature/menu/data/model/menu_model.dart';

abstract class MenuRepo{
  Future<List<MenuModel>> getMenu(String restaurantId);
}