import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/content.dart';
import '../state/portfolio_controller.dart';
import '../theme.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project, this.dimmed = false});
  final ProjectItem project;
  final bool dimmed;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;
  Offset _tilt = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final mobile = AppBreakpoints.isMobile(context);
    final showOverlay = _hovered || mobile;
    final c = PortfolioScope.of(context);

    final card = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 11,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _PreviewImages(project: widget.project),
            AnimatedOpacity(
              opacity: showOverlay ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: ColoredBox(
                color: Colors.black.withValues(alpha: _hovered ? 0.8 : 0.45),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.project.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          c.t('Click to see more', 'Kliknij, aby zobaczyć więcej'),
                          style: const TextStyle(color: AppColors.muted, fontSize: 14),
                        ),
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

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _tilt = Offset.zero;
      }),
      onHover: mobile
          ? null
          : (event) {
              final box = context.findRenderObject() as RenderBox?;
              if (box == null || !box.hasSize) return;
              final local = box.globalToLocal(event.position);
              final nx = (local.dx / box.size.width) * 2 - 1;
              final ny = (local.dy / box.size.height) * 2 - 1;
              setState(() => _tilt = Offset(nx, ny));
            },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.dimmed ? null : () => ProjectPopup.show(context, widget.project),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: widget.dimmed ? 0.28 : 1,
          child: AnimatedScale(
            scale: _hovered && !mobile && !widget.dimmed ? 1.04 : 1,
            duration: const Duration(milliseconds: 250),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0014)
                ..rotateY(_tilt.dx * 0.18)
                ..rotateX(-_tilt.dy * 0.14),
              child: card,
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewImages extends StatelessWidget {
  const _PreviewImages({required this.project});
  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final images = project.previewImages;
    if (images.length == 1) {
      return Image.asset(images.first, fit: BoxFit.cover);
    }
    return Row(
      children: [
        for (var i = 0; i < images.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i == images.length - 1 ? 0 : 2),
              child: Image.asset(images[i], fit: BoxFit.cover, height: double.infinity),
            ),
          ),
      ],
    );
  }
}

class ProjectPopup {
  static Future<void> show(BuildContext context, ProjectItem project) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withValues(alpha: 0.9),
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (context, animation, secondary) {
        return ProjectPopupView(project: project);
      },
      transitionBuilder: (context, animation, secondary, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: const Cubic(0.4, 0, 0.2, 1),
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween(begin: 0.12, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}

class ProjectPopupView extends StatefulWidget {
  const ProjectPopupView({super.key, required this.project});
  final ProjectItem project;

  @override
  State<ProjectPopupView> createState() => _ProjectPopupViewState();
}

class _ProjectPopupViewState extends State<ProjectPopupView> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.project.images.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 3), (_) {
        if (!mounted) return;
        setState(() {
          _index = (_index + 1) % widget.project.images.length;
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = AppBreakpoints.isMobile(context);
    final project = widget.project;

    final content = mobile
        ? Column(
            children: [
              Expanded(flex: 5, child: _slideshow()),
              Expanded(flex: 5, child: _info(mobile: true)),
            ],
          )
        : Row(
            children: [
              Expanded(flex: 6, child: _slideshow()),
              Expanded(flex: 5, child: _info(mobile: false)),
            ],
          );

    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(mobile ? 12 : 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1120,
              maxHeight: MediaQuery.sizeOf(context).height * (mobile ? 0.92 : 0.78),
            ),
            child: Material(
              color: const Color(0xF20A0A0A),
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  content,
                  Positioned(
                    top: 12,
                    right: 12,
                    child: _CloseButton(onTap: () => Navigator.pop(context)),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: _GithubBadge(url: project.githubUrl),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _slideshow() {
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          for (var i = 0; i < widget.project.images.length; i++)
            AnimatedOpacity(
              opacity: i == _index ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                widget.project.images[i],
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }

  Widget _info({required bool mobile}) {
    final chips = Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        for (final tech in widget.project.technologies)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0x1A0071E3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0x4D0071E3)),
            ),
            child: Text(
              tech,
              style: const TextStyle(color: AppColors.muted, fontSize: 13),
            ),
          ),
      ],
    );

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(mobile ? 20 : 28, 56, mobile ? 20 : 28, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.project.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: mobile ? 22 : 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.project.description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 15,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Technologies',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          chips,
        ],
      ),
    );
  }
}

class _CloseButton extends StatefulWidget {
  const _CloseButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedRotation(
          turns: _hovered ? 0.25 : 0,
          duration: const Duration(milliseconds: 250),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0x1AFFFFFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _GithubBadge extends StatefulWidget {
  const _GithubBadge({this.url});
  final String? url;

  @override
  State<_GithubBadge> createState() => _GithubBadgeState();
}

class _GithubBadgeState extends State<_GithubBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.url == null ? null : () => launchUrl(Uri.parse(widget.url!)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedScale(
              scale: _hovered ? 1.1 : 1,
              duration: const Duration(milliseconds: 200),
              child: const FaIcon(
                FontAwesomeIcons.github,
                color: Colors.white,
                size: 26,
              ),
            ),
            if (_hovered && widget.url == null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'This project is a school assignment and is not available.',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
