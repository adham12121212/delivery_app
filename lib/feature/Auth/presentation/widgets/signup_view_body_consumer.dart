import 'package:delivery_app/feature/Auth/presentation/cubit/auth_cubit.dart';
import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:delivery_app/feature/Auth/presentation/widgets/custom_loading.dart';
import 'package:delivery_app/feature/Auth/presentation/widgets/signup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/awesome_snack_bar_content.dart';

class SignupViewBodyConsumer extends StatelessWidget {
  const SignupViewBodyConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthSuccess){
          print('success');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              content: AwesomeSnackBarContent(
                title: 'تهانينا',
                message: 'تم تسجيل بنجاح',
                type: SnackType.success,
              ),
            ),
          );
          Navigator.of(context).pushReplacementNamed(LoginView.routeName);
        }
        if(state is AuthError){
          print('error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              content: AwesomeSnackBarContent(
                title: 'حدث خطأ',
                message: state.message,
                type: SnackType.failure,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return CustomLoadingOverlay(
            isLoading: state is AuthLoading ? true : false,
            loadingText: state is AuthLoading ? 'جاري تسجيل مستخدم جديد' : null,
            child: SignupViewBody());
      },
    );
  }
}
