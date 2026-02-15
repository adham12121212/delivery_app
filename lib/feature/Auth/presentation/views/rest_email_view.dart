import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:delivery_app/feature/Auth/presentation/widgets/rest_email_view_body_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../domain/auth_repo/reset_repo.dart';
import '../reset_cubit/reset_cubit.dart';


class RestEmailView extends StatelessWidget {
  const RestEmailView({super.key});

  static const String routeName = 'restEmail';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetCubit(
        getIt.get<ResetRepo>(),

      ),
      child: Scaffold(
        body: RestEmailViewBodyConsumer(),
      ),
    );
  }
}
