import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:delivery_app/feature/Auth/presentation/views/signup_view.dart';
import 'package:delivery_app/feature/details/presentation/view/details_view.dart';
import 'package:delivery_app/feature/home/presentation/widgets/nav_botton_bar.dart';
import 'package:delivery_app/feature/location/presentation/cubit/location_cubit.dart';
import 'package:delivery_app/feature/menu/presentation/view/menu_view.dart';
import 'package:delivery_app/feature/restaurant/data/restaurant_repo_impl/restaurant_repo_impl.dart';
import 'package:delivery_app/feature/restaurant/presentation/view/restaurant_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/Auth/data/model/user_model.dart';
import '../../feature/Auth/domain/auth_repo/auth_repo.dart';
import '../../feature/Auth/presentation/cubit/auth_cubit.dart';
import '../../feature/Auth/presentation/views/rest_email_view.dart';
import '../../feature/Auth/presentation/views/success_view.dart';
import '../../feature/cart/presentation/cubit/cart_cubit.dart';
import '../../feature/cart/presentation/view/cart_view.dart';
import '../../feature/favorite/presentation/view/favorite_view.dart';
import '../../feature/home/domain/home_repo/home_repo.dart';
import '../../feature/home/presentation/cubit/home_cubit.dart';
import '../../feature/home/presentation/view/home_view.dart';
import '../../feature/location/domain/location_repo/location_repo.dart';
import '../../feature/location/presentation/view/location_view.dart';
import '../../feature/menu/data/model/menu_model.dart';
import '../../feature/order/domain/repo_order/repo_order.dart';
import '../../feature/order/presentation/cubit/order_cubit.dart';
import '../../feature/order/presentation/view/order_view.dart';
import '../../feature/payment/view/presentation/payment_view.dart';
import '../di/get_it.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting) {
  switch (setting.name) {
    case MainNavView.routeName:
      return MaterialPageRoute(builder: (context) =>
          MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => AuthCubit(getIt.get<AuthRepo>())..getUser(),
            ),
            BlocProvider(
              create: (context) => CartCubit()..listenCart(),),
            BlocProvider(
              create: (context) => OrderCubit(getIt.get<RepoOrder>())..getOrder(
                FirebaseAuth.instance.currentUser!.uid,
              ),),
            BlocProvider(create:(context)=> LocationCubit(getIt.get<LocationRepo>())..getLocation()),
          ],

              child: MainNavView())
          );
    case OrderView.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => OrderCubit(
              getIt.get<RepoOrder>()
          )
            ..getOrder(FirebaseAuth.instance.currentUser!.uid),
          child: const OrderView(),
        ),
      );
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());
    case CartView.routeName:
      return MaterialPageRoute(builder: (context) => CartView());
    case SelectLocationView.routeName:
      return MaterialPageRoute(builder: (context) => const SelectLocationView());
      case FavoriteView.routeName:
      return MaterialPageRoute(builder: (context) => const FavoriteView());
    case RestEmailView.routeName:
      return MaterialPageRoute(builder: (context) => const RestEmailView());
    case SuccessView.routeName:
      return MaterialPageRoute(builder: (context) => const SuccessView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) =>  BlocProvider(
  create: (context) => LocationCubit(getIt.get<LocationRepo>())..getLocation(),
  child: HomeView(),
));
      case PaymentView.routeName:
      return MaterialPageRoute(builder: (context) => const PaymentView());
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