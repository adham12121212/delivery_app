import 'package:delivery_app/feature/Auth/presentation/widgets/rest_email_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../reset_cubit/reset_cubit.dart';
import '../reset_cubit/reset_state.dart';
import '../views/otp_view.dart';

class RestEmailViewBodyConsumer extends StatelessWidget {
  RestEmailViewBodyConsumer({super.key});
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetCubit, ResetState>(
      listener: (context, state) {
        if (state is OtpSent) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<ResetCubit>(),
                child: OTPView(email.text),
              ),
            ),
          );
        }

        if (state is ResetError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return RestEmailViewBody(emailController: email);
      },
    );
  }
}
