
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../menu/data/model/menu_model.dart';
import '../cubit/favorite_cubit.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.menu,
  });

  final MenuModel menu;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = false;

        if (state is FavoriteLoad) {
          isFavorite = state.favorite.any((e) => e.id == menu.id);
        }

        return
          GestureDetector(
          onTap: () {
            context.read<FavoriteCubit>().toggleFavorite(
              userId,
              menu,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 45,
            width: 45,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.accent,
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}