import 'package:delivery_app/feature/home/presentation/widgets/nav_botton_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../feature/Auth/presentation/views/login_view.dart';
import '../../feature/home/presentation/view/home_view.dart';
import '../storage/auth_local_data.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(controller);

    scaleAnimation = Tween<double>(
      begin: .8,
      end: 1,
    ).animate(controller);

    controller.forward();

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final loggedIn = await AuthLocalData.isLoggedIn();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      loggedIn ? MainNavView.routeName : LoginView.routeName,
          (route) => false,
    );
  }
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: SvgPicture.asset(
              'assets/image/logo_app.svg',
              width: 180,
            ),
          ),
        ),
      ),
    );
  }
}