// import 'dart:math';
//
// import 'package:flutter/animation.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'dart:math';
// import 'package:flutter/material.dart';
//
// import '../../config/theme/app_colors.dart';
//
// class RippleBackground extends StatefulWidget {
//   final Widget child;
//
//   const RippleBackground({super.key, required this.child});
//
//   @override
//   State<RippleBackground> createState() => _RippleBackgroundState();
// }
//
// class _RippleBackgroundState extends State<RippleBackground>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 6),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         /// 🔥 Background
//         Positioned.fill(
//           child: CustomPaint(
//             painter: StaticRipplePainter(),
//           ),
//         ),
//
//         /// 🔹 Your content
//         widget.child,
//       ],
//     );
//   }
// }
//
// class RippleBackgroundLayer extends StatefulWidget {
//   const RippleBackgroundLayer({super.key});
//
//   @override
//   State<RippleBackgroundLayer> createState() =>
//       _RippleBackgroundLayerState();
// }
//
// class _RippleBackgroundLayerState extends State<RippleBackgroundLayer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 6),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer( // 👈 IMPORTANT (no UI blocking)
//       child: CustomPaint(
//         painter: StaticRipplePainter(),
//         size: Size.infinite,
//       ),
//     );
//   }
// }
//
//
// class StaticRipplePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//
//     final baseColor = AppColors.softTeal400;
//     final rippleColor = AppColors.softTeal900;
//
//     /// Background
//     canvas.drawRect(
//       Offset.zero & size,
//       Paint()..color = baseColor,
//     );
//
//     final ringCount = 18;
//     final maxRadius =
//         (size.width > size.height ? size.width : size.height) * 0.7;
//
//     for (int i = 0; i < ringCount; i++) {
//       final progress = i / ringCount;
//       final radius = progress * maxRadius;
//
//       final paint = Paint()
//         ..color = rippleColor.withOpacity(0.8 - progress)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2 + (1 - progress) * 3
//         ..strokeCap = StrokeCap.round;
//
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: radius),
//         i * 0.4, // fixed angle (no animation)
//         2.5,     // arc length
//         false,
//         paint,
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'dart:math';

import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class RippleBackgroundLayer extends StatelessWidget {
  const RippleBackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          /// 🎨 Pattern
          const Positioned.fill(
            child: CustomPaint(
              painter: StaticRandomRipplePainter(),
            ),
          ),

          /// 🌫 Overlay for readability
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.06),
            ),
          ),
        ],
      ),
    );
  }
}


class StaticRandomRipplePainter extends CustomPainter {
  const StaticRandomRipplePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final baseColor = AppColors.softTeal400;
    final rippleColor = AppColors.softTeal100;

    /// Background
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = baseColor,
    );

    final maxRadius = sqrt(size.width * size.width +
        size.height * size.height) /
        2;

    final ringCount = 20;

    /// 🔥 deterministic randomness (so it doesn't change every rebuild)
    final random = Random(42);

    for (int i = 0; i < ringCount; i++) {
      final progress = i / ringCount;
      final radius = progress * maxRadius;

      final strokeWidth = 2 + (1 - progress) * 3;

      final opacity = 0.8 - progress * 0.7;

      final paint = Paint()
        ..color = rippleColor.withOpacity(opacity.clamp(0.1, 1))
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      /// 🔥 Create multiple broken arcs per ring
      int segments = 3 + random.nextInt(4); // 3–6 segments

      for (int s = 0; s < segments; s++) {
        final startAngle = random.nextDouble() * 2 * pi;

        final sweep = (pi / 6) + random.nextDouble() * (pi / 3);

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweep,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}