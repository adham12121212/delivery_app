
import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:delivery_app/feature/Auth/presentation/views/signup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../feature/Auth/presentation/views/otp_view.dart';
import '../../feature/Auth/presentation/views/rest_email_view.dart';
import '../../feature/Auth/presentation/views/success_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting){
  switch(setting.name){
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context)=> const LoginView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context)=> const SignupView());
      case RestEmailView.routeName:
      return MaterialPageRoute(builder: (context)=> const RestEmailView());
      case OTPView.routeName:
      return MaterialPageRoute(builder: (context)=>  OTPView(''));
      case SuccessView.routeName:
      return MaterialPageRoute(builder: (context)=> const SuccessView());
    default:
      return MaterialPageRoute(builder: (context)=> const NoScreen());
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
