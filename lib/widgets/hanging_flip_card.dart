import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/content.dart';
import '../theme.dart';

class HangingFlipCard extends StatefulWidget {
  const HangingFlipCard({super.key});

  @override
  State<HangingFlipCard> createState() => _HangingFlipCardState();
}

class _HangingFlipCardState extends State<HangingFlipCard>
    with TickerProviderStateMixin {
  late final AnimationController _flip;
  late final Ticker _ticker;
  bool _flipped = false;
  bool _dragging = false;
  bool _transitioning = false;
  Offset _offset = Offset.zero;
  Offset _velocity = Offset.zero;
  Offset _pointerStart = Offset.zero;
  Offset _offsetAtStart = Offset.zero;
  DateTime _lastMove = DateTime.now();
  Offset _lastPos = Offset.zero;
  DateTime? _lastFlip;

  static const _maxDistance = 100.0;
  static const _maxRotation = 25 * math.pi / 180;
  static const _flipCurve = Cubic(0.2, 0.85, 0.4, 1.275);

  @override
  void initState() {
    super.initState();
    _flip = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _ticker = createTicker(_onTick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _flip.dispose();
    super.dispose();
  }

  void _onTick(Duration _) {
    if (_dragging || _transitioning) return;
    const spring = 0.15;
    const damp = 0.8;
    _velocity = Offset(
      (_velocity.dx + (-_offset.dx * spring)) * damp,
      (_velocity.dy + (-_offset.dy * spring)) * damp,
    );
    _offset += _velocity;
    if (_velocity.distance < 0.05 && _offset.distance < 0.05) {
      _ticker.stop();
      if (_offset != Offset.zero) {
        setState(() => _offset = Offset.zero);
      }
      return;
    }
    setState(() {});
  }

  Future<void> _toggleFlip() async {
    if (_transitioning) return;
    final now = DateTime.now();
    if (_lastFlip != null && now.difference(_lastFlip!) < const Duration(milliseconds: 350)) {
      return;
    }
    _lastFlip = now;
    _transitioning = true;
    _flipped = !_flipped;
    if (_flipped) {
      await _flip.animateTo(1, curve: _flipCurve);
    } else {
      await _flip.animateTo(0, curve: _flipCurve);
    }
    _transitioning = false;
  }

  void _onDragStart(Offset global) {
    if (_transitioning) return;
    _dragging = true;
    _pointerStart = global;
    _offsetAtStart = _offset;
    _lastPos = global;
    _lastMove = DateTime.now();
  }

  void _onDragUpdate(Offset global) {
    if (!_dragging || _transitioning) return;
    final now = DateTime.now();
    final dt = now.difference(_lastMove).inMilliseconds / 1000;
    final delta = global - _pointerStart;
    _offset = _offsetAtStart + delta;
    if (dt > 0) {
      _velocity = (global - _lastPos) / dt;
    }
    _lastPos = global;
    _lastMove = now;
    setState(() {});
  }

  void _onDragEnd() {
    if (!_dragging) return;
    final travel = (_lastPos - _pointerStart).distance;
    _dragging = false;
    if (travel < 10) {
      _toggleFlip();
    } else if (!_ticker.isActive) {
      _ticker.start();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mobile = AppBreakpoints.isMobile(context);
    final width = mobile ? 240.0 : 300.0;
    final height = mobile ? 360.0 : 430.0;

    return AnimatedBuilder(
      animation: _flip,
      builder: (context, _) {
        final bx = _offset.dx.clamp(-_maxDistance, _maxDistance);
        final by = _offset.dy.clamp(-_maxDistance, _maxDistance);
        final rotX = (by / _maxDistance) * _maxRotation;
        final rotY = -(bx / _maxDistance) * _maxRotation;
        final flipAngle = _flip.value * math.pi;
        final angle = (flipAngle + rotY) % (2 * math.pi);
        final showBack = angle > math.pi / 2 && angle < 3 * math.pi / 2;

        final matrix = Matrix4.identity()
          ..setEntry(3, 2, 0.0012)
          ..rotateY(flipAngle + rotY)
          ..rotateX(rotX)
          ..translate(bx * 0.3, by * 0.3);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(bx * 0.15, 0),
              child: Container(
                width: 2,
                height: 28,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF2C3E50), Colors.transparent],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _toggleFlip,
              onPanStart: (d) => _onDragStart(d.globalPosition),
              onPanUpdate: (d) => _onDragUpdate(d.globalPosition),
              onPanEnd: (_) => _onDragEnd(),
              onPanCancel: _onDragEnd,
              child: Transform(
                alignment: const Alignment(0, -1.05),
                transform: matrix,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Stack(
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: showBack
                            ? (Matrix4.identity()..rotateY(math.pi))
                            : Matrix4.identity(),
                        child: showBack ? _BackFace() : _FrontFace(),
                      ),
                      if (!_flipped)
                        const Positioned(
                          top: 14,
                          right: 14,
                          child: Icon(Icons.flip, color: Colors.white70, size: 20),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FrontFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        children: [
          const Spacer(),
          ClipOval(
            child: Image.asset(
              'assets/photos/profilowe.jpeg',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            SiteContent.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
              shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            SiteContent.title,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted, fontSize: 16),
          ),
          const Spacer(),
          const _SocialRow(front: true),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _BackFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CardShell(
      reverseGradient: true,
      child: Column(
        children: [
          const Spacer(),
          const Text(
            'About me',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            SiteContent.about,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.7,
            ),
          ),
          const Spacer(),
          const _SocialRow(front: false),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child, this.reverseGradient = false});
  final Widget child;
  final bool reverseGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: reverseGradient
              ? const [AppColors.gradientEnd, AppColors.gradientStart]
              : const [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow({required this.front});
  final bool front;

  @override
  Widget build(BuildContext context) {
    final items = front
        ? [
            (FontAwesomeIcons.github, SiteLinks.github),
            (FontAwesomeIcons.linkedin, SiteLinks.linkedin),
          ]
        : [
            (FontAwesomeIcons.envelope, SiteLinks.mailto),
            (FontAwesomeIcons.mobileScreen, SiteLinks.tel),
          ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
              onPressed: () => launchUrl(
                Uri.parse(item.$2),
                mode: LaunchMode.externalApplication,
              ),
              icon: FaIcon(item.$1, color: Colors.white, size: 22),
            ),
          ),
      ],
    );
  }
}
