part of 'menu_cubit.dart';

@immutable
sealed class MenuState {}

final class MenuInitial extends MenuState {}

final class LoadingMenu extends MenuState{}

class SuccessMenu extends MenuState {
  final List<MenuModel> menu;
  final List<String> categories;

  SuccessMenu(this.menu, this.categories);
}

final class ErrorMenu extends MenuState{
  final String message;
  ErrorMenu(this.message);
}
