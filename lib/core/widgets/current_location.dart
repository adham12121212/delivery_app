import 'package:delivery_app/feature/location/domain/location_repo/location_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../feature/location/presentation/cubit/location_cubit.dart';
import '../../feature/location/presentation/cubit/location_state.dart';
import '../constant/app_color.dart';
import '../constant/app_text_style.dart';
import '../di/get_it.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        String displayDistrict = 'غير محدد';

        if (state is LocationFetchSuccess) displayDistrict = state.district!;
        if (state is LocationOutsideCairo) displayDistrict = state.district!;
        if (state is LocationFetchError) displayDistrict = state.message;

        return Row(
          children: [
            Icon(Icons.location_on, color: AppColor.accent, size: 20.r),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                displayDistrict,
                style: AppTextStyle.bold16.copyWith(color: AppColor.accent),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}