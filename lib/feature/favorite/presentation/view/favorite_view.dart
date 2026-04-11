import 'package:delivery_app/core/constant/app_color.dart';
import 'package:delivery_app/feature/favorite/domain/repo_favorite/repo_favorite.dart';
import 'package:delivery_app/feature/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_text_style.dart';
import '../../../../core/di/get_it.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  static const routeName = 'favorite';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoriteCubit(
              getIt.get<RepoFavorite>()
          )..getFavorite(FirebaseAuth.instance.currentUser!.uid),
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            'المفضل',
            style: AppTextStyle.bold19.copyWith(
              color: AppColor.accent,
            ),
          ),
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {

            if (state is FavoriteLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FavoriteError) {
              return Center(child: Text(state.message));
            }

            if (state is FavoriteLoad) {
              final favorites = state.favorite;

              if (favorites.isEmpty) {
                return const Center(child: Text("لا يوجد عناصر في المفضلة"));
              }

              return ListView.separated(
                itemCount: favorites.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final item = favorites[index];

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              item.image,
                              width: 90.w,
                              height: 90.h,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                            ),
                          ),

                          SizedBox(width: 12.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: AppTextStyle.simeBold17,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final uid = FirebaseAuth.instance.currentUser!.uid;

                                        final confirm = await showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            backgroundColor: AppColor.whiteColor,
                                            title: const Text("تأكيد"),
                                            content: const Text("عايز تمسح العنصر من المفضل؟"),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, false),
                                                child:  Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 6.h),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12.r),
                                                    color: AppColor.accent,
                                                  ),
                                                    child: Text("لا",style: AppTextStyle.bold16.copyWith(color: AppColor.whiteColor),)),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, true),
                                                child:   Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 6.h),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12.r),
                                                      color: AppColor.accent,
                                                    ),
                                                    child: Text("نعم",style: AppTextStyle.bold16.copyWith(color: AppColor.whiteColor))),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          context.read<FavoriteCubit>().removeFromFavorite(uid, item.id);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: AppColor.grey2Color,
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(height: 4.h),

                                Text(
                                  item.menuCategory,
                                  style: AppTextStyle.regular12,
                                ),

                                SizedBox(height: 8.h),

                                Text(
                                  '${item.price} جنيه',
                                  style: AppTextStyle.bold16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
