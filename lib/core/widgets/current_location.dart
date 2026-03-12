import 'package:delivery_app/feature/location/domain/location_repo/location_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../feature/location/presentation/cubit/location_cubit.dart';
import '../../feature/location/presentation/cubit/location_state.dart';
import '../constant/app_color.dart';
import '../constant/app_text_style.dart';
import '../di/get_it.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  String cityName = 'غير محدد';

  Future<void> _updateCityName(LatLng latLng) async {
    try {
      final placemarks = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          cityName = placemarks.first.locality ?? 'غير محدد';
        });
      }
    } catch (e) {
      setState(() {
        cityName = 'غير محدد';
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LocationCubit(getIt.get<LocationRepo>())..getLocation(),
      child: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          LatLng? latLng;
          if (state is LocationFetchSuccess) latLng = state.latLng;
          if (state is LocationOutsideCairo) latLng = state.latLng;
          if (latLng != null) {
            _updateCityName(latLng);
          }
        },
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            return Row(
              children: [
                Icon(Icons.location_on, color: AppColor.accent, size: 20.r),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    cityName,
                    style: AppTextStyle.bold16.copyWith(color: AppColor.accent),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );  }
}