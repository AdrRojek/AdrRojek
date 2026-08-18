import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/content.dart';
import '../state/portfolio_controller.dart';
import '../theme.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});
  final ProjectItem project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    final cover = widget.project.previewImages.first;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => ProjectPopup.show(context, widget.project),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? AppColors.accent.withValues(alpha: 0.7) : Colors.white12,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  cover,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  gaplessPlayback: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c.t(widget.project.summary, widget.project.summaryPl),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.35),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final tech in widget.project.technologies.take(3))
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tech,
                              style: const TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectPopup {
  static Future<void> show(BuildContext context, ProjectItem project) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withValues(alpha: 0.88),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (context, animation, secondary) {
        return ProjectPopupView(project: project);
      },
      transitionBuilder: (context, animation, secondary, child) {
        return FadeTransition(opacity: animation, child: child);
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
      _timer = Timer.periodic(const Duration(seconds: 4), (_) {
        if (!mounted) return;
        setState(() => _index = (_index + 1) % widget.project.images.length);
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
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
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
      child: Image.asset(
        widget.project.images[_index],
        fit: BoxFit.contain,
        gaplessPlayback: true,
        filterQuality: FilterQuality.medium,
      ),
    );
  }

  Widget _info({required bool mobile}) {
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
            style: const TextStyle(color: AppColors.muted, fontSize: 15, height: 1.7),
          ),
          const SizedBox(height: 24),
          Wrap(
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
                  child: Text(tech, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GithubBadge extends StatelessWidget {
  const _GithubBadge({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    return IconButton(
      tooltip: url == null
          ? c.t('School project — no public repo', 'Projekt szkolny — brak publicznego repo')
          : 'GitHub',
      onPressed: url == null ? null : () => launchUrl(Uri.parse(url!)),
      icon: FaIcon(
        FontAwesomeIcons.github,
        color: url == null ? Colors.white38 : Colors.white,
        size: 22,
      ),
    );
  }
}
