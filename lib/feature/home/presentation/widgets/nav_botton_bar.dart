import 'dart:ui';
import 'package:delivery_app/feature/home/presentation/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_color.dart';
import '../../../cart/presentation/view/cart_view.dart';
import '../../../menu/data/model/menu_model.dart';

class MainNavView extends StatefulWidget {
  const MainNavView({super.key});

  static const String routeName = 'mainNav';
  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  int _index = 0;

  final _pages =  [
    HomeView(),
    CartView(),
    OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _index,
            children: _pages,
          ),

          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 28.h,
            child: _GlassBottomNavBar(
              currentIndex: _index,
              onTap: (i) => setState(() => _index = i),
              items: [
                _NavItem(icon: CupertinoIcons.house_fill, label: 'الرائسيه'),
                _NavItem(icon: Icons.add_shopping_cart, label: 'السلة'),
                _NavItem(icon: Icons.receipt_long_outlined, label: 'الاوردر'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassBottomNavBar extends StatelessWidget {
  const _GlassBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<_NavItem> items;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColor.accent.withOpacity(1),
                AppColor.accent.withOpacity(0.9),
              ],
            ),
            border: Border.all(color: Colors.white.withOpacity(0.18)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (i) {
              final isSelected = i == currentIndex;
              final item = items[i];

              return InkWell(
                onTap: () => onTap(i),
                borderRadius: BorderRadius.circular(8.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.6)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 15.h,
                        color: isSelected ? Colors.white : Colors.white70,
                      ),
                       SizedBox(width: 8.w),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 12.w,
                          color: isSelected ? Colors.white : Colors.white70,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}






class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _DemoPage(title: "Orders", icon: Icons.receipt_long_outlined);
  }
}

class _DemoPage extends StatelessWidget {
  const _DemoPage({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: AppColor.whiteColor
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 60.h, color: Colors.amberAccent),
               SizedBox(height: 12.w),
              Text(
                title,
                style:  TextStyle(
                  fontSize: 28.sp,
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
