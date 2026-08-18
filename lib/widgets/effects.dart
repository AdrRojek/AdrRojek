import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    required this.id,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 40),
    this.rotation = 0,
    super.key,
  });

  final String id;
  final Widget child;
  final Duration delay;
  final Offset offset;
  final double rotation;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('reveal-${widget.id}'),
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction > 0.08) {
          Future<void>.delayed(widget.delay, () {
            if (mounted) setState(() => _visible = true);
          });
        }
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: _visible ? 1 : 0),
        duration: const Duration(milliseconds: 900),
        curve: const Cubic(0.4, 0, 0.2, 1),
        builder: (context, t, child) {
          return Opacity(
            opacity: t,
            child: Transform.translate(
              offset: Offset(
                widget.offset.dx * (1 - t),
                widget.offset.dy * (1 - t),
              ),
              child: Transform.rotate(
                angle: widget.rotation * (1 - t),
                child: child,
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class StarField extends StatefulWidget {
  const StarField({super.key});

  @override
  State<StarField> createState() => _StarFieldState();
}

class _StarFieldState extends State<StarField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 80),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _StarPainter(_controller.value),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _StarPainter extends CustomPainter {
  _StarPainter(this.t);
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.55);
    const count = 90;
    for (var i = 0; i < count; i++) {
      final nx = _hash(i, 1);
      final ny = _hash(i, 2);
      final x = nx * size.width;
      final y = ((ny + t) % 1.0) * size.height;
      canvas.drawCircle(Offset(x, y), 0.6 + _hash(i, 3) * 1.2, paint);
    }
  }

  double _hash(int i, int salt) {
    final v = math.sin(i * 12.9898 + salt * 78.233) * 43758.5453;
    return v - v.floorToDouble();
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) => oldDelegate.t != t;
}

class CursorGlow extends StatefulWidget {
  const CursorGlow({super.key, required this.child});
  final Widget child;

  @override
  State<CursorGlow> createState() => _CursorGlowState();
}

class _CursorGlowState extends State<CursorGlow> {
  Offset? _pos;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isTouch = (MediaQuery.maybeOf(context)?.size.width ?? 800) < 800;
    return MouseRegion(
      opaque: false,
      onHover: isTouch ? null : (e) => setState(() => _pos = e.localPosition),
      onExit: (_) => setState(() => _pos = null),
      child: Listener(
        onPointerDown: (_) => setState(() => _pressed = true),
        onPointerUp: (_) => setState(() => _pressed = false),
        onPointerCancel: (_) => setState(() => _pressed = false),
        child: Stack(
          children: [
            widget.child,
            if (!isTouch && _pos != null)
              Positioned(
                left: _pos!.dx - (_pressed ? 50 : 100),
                top: _pos!.dy - (_pressed ? 50 : 100),
                child: IgnorePointer(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _pressed ? 100 : 200,
                    height: _pressed ? 100 : 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFF8A2BE2).withValues(alpha: _pressed ? 0.45 : 0.28),
                          Color(0xFF8A2BE2).withValues(alpha: 0.12),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
