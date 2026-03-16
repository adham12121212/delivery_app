import 'package:delivery_app/feature/Auth/data/model/user_model.dart';
import 'package:delivery_app/feature/Auth/presentation/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/awesome_snack_bar_content.dart';
import '../cubit/auth_cubit.dart';
import '../views/login_view.dart';
import 'custom_loading.dart';

class ProfileViewConsumerBody extends StatelessWidget {
  const ProfileViewConsumerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {

        if (state is AuthLoggedOut) {
          Navigator.pushReplacementNamed(context, LoginView.routeName);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              content: AwesomeSnackBarContent(
                title: 'تهانينا',
                message: 'تم تسجيل الخروج بنجاح',
                type: SnackType.success,
              ),
            ),
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      builder: (context, state) {

        if (state is AuthSuccess) {
          return CustomLoadingOverlay(
            isLoading: false,
            child: ProfileViewBody(user: state.user),
          );
        }

        /// أثناء التحميل
        if (state is AuthLoading) {
          return const CustomLoadingOverlay(
            isLoading: true,
            loadingText: 'جاري التحميل',
            child: SizedBox(),
          );
        }

        return const SizedBox();
      },
    );
  }
}