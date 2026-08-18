import 'package:flutter/material.dart';

import '../data/content.dart';
import '../state/portfolio_controller.dart';
import '../theme.dart';
import '../util/site_actions.dart';

class RecruiterBrief extends StatelessWidget {
  const RecruiterBrief({super.key, required this.onJump});

  final void Function(String section) onJump;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    return Material(
      color: Colors.black.withValues(alpha: 0.62),
      child: GestureDetector(
        onTap: () => c.setBrief(false),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640, maxHeight: 680),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFF101114),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.accent.withValues(alpha: 0.45)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.bolt, color: AppColors.accent),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                c.t('Recruiter brief · 30 seconds', 'Briefing rekrutera · 30 sekund'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => c.setBrief(false),
                              icon: const Icon(Icons.close, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${SiteContent.name}  ·  ${c.t(SiteContent.title, 'Student informatyki')}',
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _Pill(c.t('Open to internships', 'Otwarty na praktyki'), const Color(0xFF22C55E)),
                            _Pill(c.t('Flutter · SwiftUI · Kotlin', 'Flutter · SwiftUI · Kotlin'), AppColors.accent),
                            _Pill(c.t('English C1 · German B1', 'Angielski C1 · Niemiecki B1'), AppColors.purple),
                            _Pill(WarsawClock.label(), Colors.white54),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _Heading(c.t('Latest roles', 'Ostatnie role')),
                        _Line('Mobile App Developer (Flutter) — DEVEJI, 08.2025–10.2025'),
                        _Line('Web Developer — NEW PORTABLE DEVICES, 05.2025–07.2025'),
                        _Line('Apprentice — G2A.COM R&D Center, 06.2025–07.2025'),
                        const SizedBox(height: 16),
                        _Heading(c.t('What I ship', 'Co dowożę')),
                        _Line(c.t(
                          'Native-feeling mobile apps (iOS + Android) and full-stack school/ intern systems.',
                          'Aplikacje mobilne (iOS + Android) oraz systemy webowe ze studiów i praktyk.',
                        )),
                        _Line(c.t(
                          'Comfortable jumping between SwiftUI, Flutter, Kotlin, PHP/Laravel and Java.',
                          'Swobodnie przełączam się między SwiftUI, Flutter, Kotlin, PHP/Laravel i Javą.',
                        )),
                        const SizedBox(height: 16),
                        _Heading(c.t('Proof', 'Dowody')),
                        for (final project in SiteContent.projects.take(4))
                          _Line('${project.title}  ·  ${project.technologies.take(3).join(', ')}'),
                        const SizedBox(height: 22),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _ActionButton(
                              label: c.t('Copy email', 'Kopiuj e-mail'),
                              onTap: () => SiteActions.copy(
                                context,
                                SiteLinks.email,
                                c.t('Email copied', 'Skopiowano e-mail'),
                              ),
                            ),
                            _ActionButton(
                              label: 'GitHub',
                              onTap: () => SiteActions.open(SiteLinks.github),
                            ),
                            _ActionButton(
                              label: 'LinkedIn',
                              onTap: () => SiteActions.open(SiteLinks.linkedin),
                            ),
                            _ActionButton(
                              label: c.t('See projects', 'Zobacz projekty'),
                              filled: true,
                              onTap: () {
                                c.setBrief(false);
                                onJump('projects');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 11,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(color: Colors.white, height: 1.35)),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text, this.color);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: filled ? AppColors.accent : Colors.white12,
        foregroundColor: Colors.white,
      ),
      child: Text(label),
    );
  }
}
