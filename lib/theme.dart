import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF000000);
  static const footer = Color(0xFF1D1D1F);
  static const card = Color(0x1AFFFFFF);
  static const cardBorder = Color(0x1AFFFFFF);
  static const accent = Color(0xFF0071E3);
  static const purple = Color(0xFF8A2BE2);
  static const gradientStart = Color(0xFF2C3E50);
  static const gradientEnd = Color(0xFF3498DB);
  static const muted = Color(0xCCFFFFFF);
}

class AppBreakpoints {
  static const mobile = 800.0;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;
}

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
