
import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:delivery_app/feature/Auth/presentation/views/signup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting){
  switch(setting.name){
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context)=> const LoginView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context)=> const SignupView());
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
