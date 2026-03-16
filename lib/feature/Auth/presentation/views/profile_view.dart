import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:delivery_app/feature/Auth/presentation/widgets/profile_view_consumer_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/widgets/awesome_snack_bar_content.dart';
import '../../data/model/user_model.dart';
import '../../domain/auth_repo/auth_repo.dart';
import '../cubit/auth_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return  ProfileViewConsumerBody();

  }


}