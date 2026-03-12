import 'package:delivery_app/feature/Auth/presentation/cubit/auth_cubit.dart';
import 'package:delivery_app/feature/Auth/presentation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/auth_local_data.dart';
import '../../../../core/widgets/awesome_snack_bar_content.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../../home/presentation/widgets/nav_botton_bar.dart';
import '../../../location/presentation/view/location_view.dart';
import 'login_view_body.dart';


class LoginViewBodyConsumer extends StatelessWidget {
  const LoginViewBodyConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async{
        if(state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              content: AwesomeSnackBarContent(
                title: 'تهانينا',
                message: 'تم تسجيل الدخول بنجاح',
                type: SnackType.success,
              ),
            ),
          );
          await AuthLocalData.saveLoginState(true);
          final hasLocation = await AuthLocalData.hasLocation();
          if (hasLocation) {
            Navigator.pushReplacementNamed(context, MainNavView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, SelectLocationView.routeName);
          }
        }
        if(state is AuthError){
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
           )
         );
        }
      },
      builder: (context, state) {
        return CustomLoadingOverlay(
            isLoading: state is AuthLoading ? true : false,
            loadingText: state is AuthLoading ? 'جاري تسجيل الدخول' : null,
            child: LoginViewBody());
      },
    );
  }
}
