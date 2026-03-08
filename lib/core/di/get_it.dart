

import 'package:delivery_app/feature/home/data/home_repo_impl/home_repo_impl.dart';
import 'package:delivery_app/feature/home/domain/home_repo/home_repo.dart';
import 'package:delivery_app/feature/menu/data/menu_repo_iml/menu_repo_impl.dart';
import 'package:delivery_app/feature/menu/domain/menu_repo/menu_repo.dart';
import 'package:delivery_app/feature/menu/presentation/cubit/menu_cubit.dart';
import 'package:delivery_app/feature/restaurant/data/restaurant_repo_impl/restaurant_repo_impl.dart';
import 'package:delivery_app/feature/restaurant/domain/restaurant_repo/restaurant_reop.dart';
import 'package:delivery_app/feature/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../feature/Auth/data/auth_repo_impl/auth_repo_impl.dart';
import '../../feature/Auth/data/auth_repo_impl/login_repo.dart';
import '../../feature/Auth/data/auth_repo_impl/reset_repo_impl.dart';
import '../../feature/Auth/domain/auth_repo/auth_repo.dart';
import '../../feature/Auth/domain/auth_repo/reset_repo.dart';
import '../../feature/Auth/presentation/rest_api_cubit/restapi_cubit.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';
import '../service/firebase_service.dart';
import '../service/firestore_data.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<FireBaseService>(() => FireBaseService());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
    fireBaseService: getIt.get<FireBaseService>(),
    fireStoreData: getIt.get<FireStoreData>(),
  ));
  getIt.registerLazySingleton<ResetRepo>(() => ResetRepoImpl(
    getIt.get<FireBaseService>(),
  ));

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt.get<ApiService>(),));
  getIt.registerLazySingleton<RestapiCubit>(() => RestapiCubit(getIt.get<LoginRepo>(),));
  getIt.registerLazySingleton<FireStoreData>(() => FireStoreData());
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(
    getIt.get<FireStoreData>(),
  ));
  getIt.registerLazySingleton<RestaurantRepo>(() => RestaurantRepoImpl(
    getIt.get<FireStoreData>(),
  ));
  getIt.registerLazySingleton<MenuRepo>(() => MenuRepoImpl(
    getIt.get<FireStoreData>(),
  ));
  getIt.registerFactory<RestaurantCubit>(() => RestaurantCubit(getIt.get<RestaurantRepo>(),));
  getIt.registerFactory<MenuCubit>(() => MenuCubit(getIt.get<MenuRepo>(),));



}



