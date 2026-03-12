import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:delivery_app/feature/Auth/presentation/views/signup_view.dart';
import 'package:delivery_app/feature/details/presentation/view/details_view.dart';
import 'package:delivery_app/feature/home/presentation/widgets/nav_botton_bar.dart';
import 'package:delivery_app/feature/menu/presentation/view/menu_view.dart';
import 'package:delivery_app/feature/restaurant/presentation/view/restaurant_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/Auth/presentation/views/otp_view.dart';
import '../../feature/Auth/presentation/views/rest_email_view.dart';
import '../../feature/Auth/presentation/views/success_view.dart';
import '../../feature/cart/presentation/cubit/cart_cubit.dart';
import '../../feature/cart/presentation/view/cart_view.dart';
import '../../feature/home/presentation/view/home_view.dart';
import '../../feature/location/presentation/view/location_view.dart';
import '../../feature/menu/data/model/menu_model.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting) {
  switch (setting.name) {
    case MainNavView.routeName:
      return MaterialPageRoute(builder: (context) =>
          BlocProvider(
            create: (context) => CartCubit(),
            child: MainNavView(),
          ));
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());
    case CartView.routeName:
      return MaterialPageRoute(builder: (context) => CartView());
    case SelectLocationView.routeName:
      return MaterialPageRoute(builder: (context) => const SelectLocationView());
    case RestEmailView.routeName:
      return MaterialPageRoute(builder: (context) => const RestEmailView());
    case OTPView.routeName:
      return MaterialPageRoute(builder: (context) => OTPView(''));
    case SuccessView.routeName:
      return MaterialPageRoute(builder: (context) => const SuccessView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case RestaurantView.routeName:
      final category = setting.arguments as String?;
      return MaterialPageRoute(
        builder: (context) => RestaurantView(category: category),
        settings: setting,
      );
    case MenuView.routeName:
      final args = setting.arguments as Map<String, dynamic>;
      return MaterialPageRoute(builder: (context) =>
          MenuView(
            restaurantId: args['id'],
            restaurantTitle: args['title'],
            restaurantImage: args['image'],
            restaurantRating: args['rating'],
          ));

    case DetailsView.routeName:
      final menu = setting.arguments as MenuModel;
      return MaterialPageRoute(
        builder: (context) => BlocProvider<CartCubit>(
          create: (context) => CartCubit(), // هنا فقط لشاشة DetailsView
          child: DetailsView(menu: menu),
        ),
      );
    default:
      return MaterialPageRoute(builder: (context) => const NoScreen());
  }
}


class NoScreen extends StatelessWidget {
  const NoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No Screen'),
      ),
    );
  }
}