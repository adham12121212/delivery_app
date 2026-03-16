import 'package:delivery_app/core/di/get_it.dart';
import 'package:delivery_app/feature/Auth/presentation/cubit/auth_cubit.dart';
import 'package:delivery_app/feature/Auth/presentation/widgets/signup_view_body_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/user_model.dart';
import '../../domain/auth_repo/auth_repo.dart';
import '../widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const String routeName = 'signup';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => AuthCubit(
          getIt.get<AuthRepo>(),
        ),
        child: Scaffold(
          body: SignupViewBodyConsumer(),
        ),
      ),
    );
  }
}
