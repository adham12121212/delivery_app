import 'package:delivery_app/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../data/auth_repo_impl/login_repo.dart';
import '../../domain/auth_repo/auth_repo.dart';
import '../cubit/auth_cubit.dart';
import '../rest_api_cubit/restapi_cubit.dart';
import '../widgets/login_view_body_consumer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => AuthCubit(
          getIt.get<AuthRepo>(),
        ),
        child: Scaffold(
          backgroundColor: AppColor.accent,
          body: LoginViewBodyConsumer(),
        ),
      ),
    );
  }
}



