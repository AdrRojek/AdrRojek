import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MatrixRain extends StatefulWidget {
  const MatrixRain({super.key});

  @override
  State<MatrixRain> createState() => _MatrixRainState();
}

class _MatrixRainState extends State<MatrixRain>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if ((elapsed - _elapsed) < const Duration(milliseconds: 32)) return;
      setState(() => _elapsed = elapsed);
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _MatrixPainter(_elapsed.inMilliseconds / 1000),
        size: Size.infinite,
      ),
    );
  }
}

class _MatrixPainter extends CustomPainter {
  _MatrixPainter(this.t);
  final double t;
  static const _glyphs = r'01ABCDEFGHJKLMNPQRSTUVWXYZ#%$&<>/\\';

  @override
  void paint(Canvas canvas, Size size) {
    const colW = 18.0;
    final cols = (size.width / colW).ceil();
    final tp = TextPainter(textDirection: TextDirection.ltr);

    for (var c = 0; c < cols; c++) {
      final seed = _hash(c, 7);
      final speed = 40 + seed * 90;
      final head = ((t * speed) + seed * size.height) % (size.height + 120);
      final trail = 12 + (seed * 10).floor();
      for (var i = 0; i < trail; i++) {
        final y = head - i * 16;
        if (y < -20 || y > size.height + 20) continue;
        final gi = ((c * 13 + i * 7 + (t * 8).floor()) % _glyphs.length);
        final alpha = i == 0 ? 0.9 : (0.28 * (1 - i / trail)).clamp(0.0, 0.4);
        tp
          ..text = TextSpan(
            text: _glyphs[gi],
            style: TextStyle(
              color: Color.fromRGBO(80, 255, 140, alpha),
              fontSize: 13,
              fontFamily: 'monospace',
              height: 1,
            ),
          )
          ..layout();
        tp.paint(canvas, Offset(c * colW, y));
      }
    }
  }

  double _hash(int i, int salt) {
    final v = math.sin(i * 12.9898 + salt * 78.233) * 43758.5453;
    return v - v.floorToDouble();
  }

  @override
  bool shouldRepaint(covariant _MatrixPainter oldDelegate) => oldDelegate.t != t;
}
