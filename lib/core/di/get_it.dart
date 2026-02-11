

import 'package:get_it/get_it.dart';
import '../../feature/Auth/data/auth_repo_impl/auth_repo_impl.dart';
import '../../feature/Auth/domain/auth_repo/auth_repo.dart';
import '../service/firebase_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<FireBaseService>(() => FireBaseService());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
    fireBaseService: getIt.get<FireBaseService>(),
  ));

  }



