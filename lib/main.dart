import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:delivery_app/feature/Auth/presentation/views/otp_view.dart';
import 'package:delivery_app/feature/Auth/presentation/views/signup_view.dart';
import 'package:delivery_app/feature/Auth/presentation/views/success_view.dart';
import 'package:delivery_app/feature/home/presentation/view/home_view.dart';
import 'package:delivery_app/feature/home/presentation/widgets/nav_botton_bar.dart';
import 'package:delivery_app/feature/location/presentation/view/location_view.dart';
import 'package:delivery_app/feature/menu/presentation/view/menu_view.dart';
import 'package:delivery_app/feature/restaurant/presentation/view/restaurant_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/get_it.dart';
import 'core/route/route.dart';
import 'core/startup/startup_view.dart';
import 'feature/details/presentation/view/details_view.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ar'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'IBM Plex Sans Arabic',
        ),
        onGenerateRoute: onGenerateRoute,
        home:  StartupView(),
      ),
    );
  }
}