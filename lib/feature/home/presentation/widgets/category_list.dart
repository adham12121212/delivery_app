import 'package:delivery_app/feature/restaurant/presentation/view/restaurant_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../restaurant/presentation/view/restaurant_view.dart' as routName;
import 'category_card.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}
class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;

  final categories = const [
    ('اكل', '🍔'),
    ('حلويات', '🍰'),
    ('مكسيكي', '🌮'),
    ('صينى', '🥡'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 14.w),
        itemBuilder: (context, index) {
          return CategoryCard(
            title: categories[index].$1,
            emoji: categories[index].$2,
            isSelected: selectedIndex == index,
            onTap: () {
              setState(() => selectedIndex = index);
              final category = categories[index].$1;
              Navigator.of(context).pushNamed(
                RestaurantView.routeName,
                arguments: category,
              );
            },
          );
        },
      ),
    );
  }
}