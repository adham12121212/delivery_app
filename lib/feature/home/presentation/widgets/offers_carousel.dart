import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_color.dart';
import '../cubit/home_cubit.dart';
import 'offer_card.dart';

class OffersCarousel extends StatefulWidget {
  const OffersCarousel({super.key});

  @override
  State<OffersCarousel> createState() => _OffersCarouselState();
}

class _OffersCarouselState extends State<OffersCarousel> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return SizedBox(
            height: 170.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeSuccess) {
          final offers = state.offers;
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: offers.length,
                itemBuilder: (context, index, realIndex) {
                  final offer = offers[index];
                  return OfferCard(
                    title: offer.title,
                    desc: "اكتشف أفضل العروض على مطاعمك المفضلة",
                    buttonText: 'اطلب الآن',
                    imageUrl: offer.image,
                  );
                },
                options: CarouselOptions(
                  height: 170.h,
                  viewportFraction: 0.99,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration:
                  const Duration(milliseconds: 450),
                  autoPlayCurve: Curves.easeInOut,
                  onPageChanged: (index, reason) {
                    setState(() => _currentIndex = index);
                  },
                ),
              ),

              SizedBox(height: 12.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  offers.length,
                      (i) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: _currentIndex == i ? 10.w : 7.w,
                    height: _currentIndex == i ? 10.w : 7.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == i
                          ? AppColor.whiteColor
                          : AppColor.whiteColor.withValues(alpha: .35),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        if (state is HomeError) {
          return SizedBox(
            height: 170.h,
            child: Center(child: Text(state.message)),
          );
        }

        return const SizedBox();
      },
    );
  }
}
