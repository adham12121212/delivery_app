import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/storage/auth_local_data.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../data/location_repo_impl/location_repo_impl.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';
import '../../../../core/service/firestore_data.dart';

class SelectLocationView extends StatelessWidget {
  const SelectLocationView({super.key});
  static const routeName = 'location';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit(LocationRepoImpl(FireStoreData()))..getLocation(),
      child: const _SelectLocationBody(),
    );
  }
}

class _SelectLocationBody extends StatefulWidget {
  const _SelectLocationBody();

  @override
  State<_SelectLocationBody> createState() => _SelectLocationBodyState();
}

class _SelectLocationBodyState extends State<_SelectLocationBody> {
  GoogleMapController? mapController;
  LatLng? _centerLatLng;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  static const double minLat = 29.95;
  static const double maxLat = 30.20;
  static const double minLng = 31.10;
  static const double maxLng = 31.40;

  LatLng _clampToCairo(LatLng latLng) {
    final lat = latLng.latitude.clamp(minLat, maxLat);
    final lng = latLng.longitude.clamp(minLng, maxLng);
    return LatLng(lat, lng);
  }

  void _animateTo(LatLng latLng) {
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اختيار الموقع", style: AppTextStyle.bold19.copyWith(color: AppColor.whiteColor)),
        backgroundColor: AppColor.accent,
      ),
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationFetchSuccess || state is LocationOutsideCairo) {
            _centerLatLng = _clampToCairo(state.latLng!);
            _animateTo(_centerLatLng!);
          }
          if (state is LocationSaveSuccess) Navigator.pushReplacementNamed(context, HomeView.routeName);
        },
        builder: (context, state) {
          final cubit = context.read<LocationCubit>();
          final isLoading = state is LocationFetchLoading;
          final isSaving = state is LocationSaveLoading;
          final canConfirm = _centerLatLng != null;

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(30.0444, 31.2357),
                  zoom: 12,
                ),
                onMapCreated: (controller) async {
                  mapController = controller;
                  final style = await DefaultAssetBundle.of(context)
                      .loadString('assets/mapStyle/map_style.json');
                  mapController?.setMapStyle(style);
                },
                onCameraMove: (position) {
                  _centerLatLng = _clampToCairo(position.target);
                },
                myLocationEnabled: true,
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                markers: _centerLatLng == null
                    ? {}
                    : {
                  Marker(
                    markerId: const MarkerId('center'),
                    position: _centerLatLng!,
                    draggable: true,
                    onDragEnd: (newLatLng) {
                      setState(() => _centerLatLng = _clampToCairo(newLatLng));
                    },
                  ),
                },
              ),

              if (isLoading || isSaving)
                Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator(color: Colors.white))),

              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: ElevatedButton.icon(
                  onPressed: canConfirm
                      ? () async {
                    final finalLatLng = _centerLatLng!;
                    await cubit.saveLocation(finalLatLng);
                    await AuthLocalData.saveLocation(finalLatLng.latitude, finalLatLng.longitude);
                  }
                      : null,
                  icon: isSaving
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                      : const Icon(Icons.check_circle_outline, color: AppColor.whiteColor),
                  label: Text(
                    isSaving ? 'جارٍ الحفظ...' : 'تأكيد الموقع',
                    style: AppTextStyle.simeBold17.copyWith(color: AppColor.whiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.accent,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}