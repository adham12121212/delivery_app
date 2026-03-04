import 'package:delivery_app/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  static const routeName = 'details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        titleSpacing: 16,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 25),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
