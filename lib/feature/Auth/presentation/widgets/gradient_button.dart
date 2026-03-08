import 'package:flutter/material.dart';

import '../../../../core/constant/app_color.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool loading;

  const GradientButton({
    required this.text,
    required this.onTap,
    this.loading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColor.accent
        ),
        alignment: Alignment.center,
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
