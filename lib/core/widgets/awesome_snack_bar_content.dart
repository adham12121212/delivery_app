import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SnackType { success, failure, warning, help }

class AwesomeSnackBarContent extends StatelessWidget {
  const AwesomeSnackBarContent({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.onClose,
    this.maxLines = 3,
  });

  final String title;
  final String message;
  final SnackType type;
  final VoidCallback? onClose;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final config = _SnackConfig.fromType(type);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // الخلفية
        Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: config.color,
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: CustomPaint(
              painter: _SnackPatternPainter(
                baseColor: config.darkColor,
              ),
            ),
          ),
        ),

        Positioned(
          right: 6,
          top: 6,
          child: GestureDetector(
            onTap: onClose,
            child: const SizedBox(
              width: 34,
              height: 34,
              child: Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),

        // محتوى الرسالة
        Padding(
          padding: const EdgeInsets.only(left: 58, right: 40, top: 14, bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.92),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),

        // Bubble icon (زي اللي فوق الكارد)
        Positioned(
          left: 14,
          top: -14,
          child: _BubbleIcon(
            icon: config.icon,
            background: config.darkColor,
          ),
        ),
      ],
    );
  }
}

class _SnackPatternPainter extends CustomPainter {
  final Color baseColor;

  _SnackPatternPainter({required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    final wavePaint = Paint()
      ..color = baseColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height * 0.6);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.85,
      size.width * 0.55,
      size.height * 0.65,
    );

    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.45,
      size.width,
      size.height * 0.7,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);

    /// Decorative Circles
    final circlePaint = Paint()
      ..color = baseColor.withOpacity(0.06)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.25),
      32,
      circlePaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.8),
      22,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BubbleIcon extends StatelessWidget {
  const _BubbleIcon({required this.icon, required this.background});
  final IconData icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: background.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Center(
          child:
          Icon(icon, color: Colors.white, size: 24)),
    );
  }
}

class _SnackConfig {
  final Color color;
  final Color darkColor;
  final IconData icon;

  const _SnackConfig({
    required this.color,
    required this.darkColor,
    required this.icon,
  });

  factory _SnackConfig.fromType(SnackType type) {
    switch (type) {
      case SnackType.success:
        return const _SnackConfig(
          color: Color(0xFF4CA28A),
          darkColor: Color(0xFF1E5D4C),
          icon: Icons.check,
        );
      case SnackType.failure:
        return const _SnackConfig(
          color: Color(0xFFF44336),
          darkColor: Color(0xFFDE3F3F),
          icon: Icons.error,
        );
      case SnackType.warning:
        return const _SnackConfig(
          color: Color(0xFFF39C34),
          darkColor: Color(0xFFD97A14),
          icon: Icons.warning_amber_rounded,
        );
      case SnackType.help:
        return const _SnackConfig(
          color: Color(0xFF1976D2),
          darkColor: Color(0xFF0D47A1),
          icon: Icons.question_mark_rounded,
        );
    }
  }
}
