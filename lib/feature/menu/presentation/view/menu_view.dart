import 'package:delivery_app/feature/menu/domain/menu_repo/menu_repo.dart';
import 'package:delivery_app/feature/menu/presentation/cubit/menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../data/model/menu_model.dart';
import '../widgets/build_section.dart';
import '../widgets/card_item_menu.dart';
import '../widgets/restaurant_menu_header.dart';

class MenuView extends StatefulWidget {
  const MenuView({
    super.key,
    required this.restaurantTitle,
    required this.restaurantImage,
    required this.restaurantRating,
    required this.restaurantId,
  });

  static const String routeName = 'menu';

  final String restaurantTitle;
  final String restaurantImage;
  final String restaurantRating;
  final String restaurantId;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final ScrollController _scrollController = ScrollController();

  final Map<String, double> _sectionOffsets = {};


  void _registerSectionOffset(String category, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) return;

      final position = renderBox.localToGlobal(Offset.zero);

      _sectionOffsets[category] =
          _scrollController.offset + (position.dy-135);
    });
  }


  void scrollToSection(int index, List<String> categories) {
    if (index >= categories.length) return;

    final category = categories[index];
    final offset = _sectionOffsets[category];
    if (offset == null) return;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) =>
        MenuCubit(getIt<MenuRepo>())..getMenu(widget.restaurantId),
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColor.whiteColor,
            toolbarHeight: 50.h,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 25),
              onPressed: () => Navigator.pop(context),
            ),

          ),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.w),
            child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state is LoadingMenu) {
                  return  ListView.builder(
                    itemCount: 3,
                    itemBuilder: (_, __) => BuildSection(
                      title: 'Loading',
                      items: List.generate(
                        4,
                            (index) => MenuModel.mock(), // أو dummy data
                      ),
                      isLoading: true,
                    ),
                  );
                }

                if (state is ErrorMenu) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                if (state is SuccessMenu) {
                  final menus = state.menu;
                  final categories = state.categories;

                  return ListView(
                    controller: _scrollController,
                    padding:  EdgeInsets.symmetric(
                        horizontal: 4.w, vertical: 10.h),
                    children: [
                      RestaurantMenuHeader(widget: widget),

                       SizedBox(height: 25.h),

                      CardItemMenu(
                        menuCategory: categories,
                        onCategorySelected: (index) =>
                            scrollToSection(index, categories),
                      ),

                       SizedBox(height: 25.h),

                      ...categories.map((category) {
                        final filtered = menus
                            .where((item) =>
                        item.menuCategory
                            .trim()
                            .toLowerCase() ==
                            category.toLowerCase() &&
                            item.isAvailable)
                            .toList();

                        return Builder(
                          builder: (context) {
                            _registerSectionOffset(category, context);
                            return BuildSection(
                              title: category,
                              items: filtered,
                            );
                          },
                        );
                      }).toList(),

                       SizedBox(height: 10.h),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}