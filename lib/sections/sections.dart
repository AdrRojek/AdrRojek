import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/content.dart';
import '../state/portfolio_controller.dart';
import '../theme.dart';
import '../widgets/effects.dart';
import '../widgets/hanging_flip_card.dart';
import '../widgets/project_widgets.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onScrollDown});
  final VoidCallback onScrollDown;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounce;

  @override
  void initState() {
    super.initState();
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const HangingFlipCard(),
          Positioned(
            top: 88,
            left: 24,
            right: 24,
            child: TypingRoles(
              lines: [
                PortfolioScope.of(context).t(
                  'Mobile App Developer',
                  'Twórca aplikacji mobilnych',
                ),
                PortfolioScope.of(context).t(
                  'Computer Science student',
                  'Student informatyki',
                ),
                'SwiftUI  ·  Flutter  ·  Kotlin',
              ],
            ),
          ),
          Positioned(
            bottom: 28,
            child: AnimatedBuilder(
              animation: _bounce,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -10 * _bounce.value),
                  child: child,
                );
              },
              child: IconButton(
                onPressed: widget.onScrollDown,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = AppBreakpoints.isMobile(context);
    final education = _InfoCard(
      title: '🎓 Education',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in SiteContent.education) _Bullet(item),
        ],
      ),
    );
    final experience = _InfoCard(
      title: '💼 Experience',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in SiteContent.experience) _Bullet(item),
        ],
      ),
    );
    final languages = _InfoCard(
      title: '🌍 Languages',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in SiteContent.languages) _Bullet(item),
        ],
      ),
    );
    final certificates = _InfoCard(
      title: '🥇 Certificates',
      child: Column(
        children: [
          for (final cert in SiteContent.certificates)
            PreviewHover(
              image: cert.image,
              child: _Bullet(cert.title, trailing: const Text('📜')),
            ),
        ],
      ),
    );
    final exams = _InfoCard(
      title: '🛠️ Professional Exams',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('EE.08', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          for (final line in SiteContent.examEe08)
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 4),
              child: Text(line, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
            ),
          const SizedBox(height: 10),
          const Text('EE.09', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          for (final line in SiteContent.examEe09)
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 4),
              child: Text(line, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
            ),
          const SizedBox(height: 12),
          const Center(
            child: PreviewHover(
              image: 'assets/photos/dyplom.png',
              preferLeft: true,
              child: SizedBox(
                width: 28,
                child: Image(
                  image: AssetImage('assets/photos/dyplom.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (mobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
        child: Column(
          children: [
            ScrollReveal(id: 'edu', offset: const Offset(0, 80), child: education),
            const SizedBox(height: 16),
            ScrollReveal(id: 'exp', offset: const Offset(0, 80), child: experience),
            const SizedBox(height: 16),
            ScrollReveal(id: 'lang', offset: const Offset(0, 80), child: languages),
            const SizedBox(height: 16),
            ScrollReveal(id: 'cert', offset: const Offset(0, 80), child: certificates),
            const SizedBox(height: 16),
            ScrollReveal(id: 'exam', offset: const Offset(0, 80), child: exams),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    ScrollReveal(
                      id: 'edu',
                      offset: const Offset(-240, 0),
                      rotation: -0.6,
                      child: education,
                    ),
                    const SizedBox(height: 16),
                    ScrollReveal(
                      id: 'cert',
                      offset: const Offset(-240, 0),
                      rotation: -0.6,
                      child: certificates,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: ScrollReveal(
                  id: 'exp',
                  offset: const Offset(0, 50),
                  child: experience,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    ScrollReveal(
                      id: 'lang',
                      offset: const Offset(240, 0),
                      rotation: 0.6,
                      child: languages,
                    ),
                    const SizedBox(height: 16),
                    ScrollReveal(
                      id: 'exam',
                      offset: const Offset(240, 0),
                      rotation: 0.6,
                      child: exams,
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text, {this.trailing});
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(color: AppColors.accent, fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: AppColors.muted, height: 1.45),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class PreviewHover extends StatefulWidget {
  const PreviewHover({
    super.key,
    required this.image,
    required this.child,
    this.preferLeft = false,
  });

  final String image;
  final Widget child;
  final bool preferLeft;

  @override
  State<PreviewHover> createState() => _PreviewHoverState();
}

class _PreviewHoverState extends State<PreviewHover> {
  OverlayEntry? _entry;

  void _show() {
    _hide();
    final overlay = Overlay.of(context, rootOverlay: true);
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final origin = box.localToGlobal(Offset.zero);
    final size = box.size;
    const previewW = 320.0;
    const previewH = 400.0;

    _entry = OverlayEntry(
      builder: (context) {
        final screen = MediaQuery.sizeOf(context);
        var left = widget.preferLeft
            ? origin.dx - previewW - 16
            : origin.dx + size.width + 16;
        var top = origin.dy + size.height / 2 - previewH / 2;
        left = left.clamp(12.0, (screen.width - previewW - 12).clamp(12.0, screen.width));
        top = top.clamp(12.0, (screen.height - previewH - 12).clamp(12.0, screen.height));

        return Positioned(
          left: left,
          top: top,
          width: previewW,
          height: previewH,
          child: IgnorePointer(
            child: Material(
              color: const Color(0xFF111111),
              elevation: 32,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: ColoredBox(
                color: const Color(0xFF111111),
                child: Image.asset(widget.image, fit: BoxFit.contain),
              ),
            ),
          ),
        );
      },
    );
    overlay.insert(_entry!);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = AppBreakpoints.isMobile(context);
    return MouseRegion(
      onEnter: mobile ? null : (_) => _show(),
      onExit: mobile ? null : (_) => _hide(),
      child: GestureDetector(
        onTap: mobile
            ? () {
                if (_entry == null) {
                  _show();
                } else {
                  _hide();
                }
              }
            : null,
        child: widget.child,
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              ScrollReveal(
                id: 'skills-title',
                child: _SectionTitle(c.t('Specializations', 'Specjalizacje')),
              ),
              const SizedBox(height: 8),
              Text(
                c.t(
                  'Tap a skill to highlight matching projects.',
                  'Kliknij umiejętność, aby podświetlić pasujące projekty.',
                ),
                style: const TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final twoCols = constraints.maxWidth > 800;
                  final cards = [
                    ScrollReveal(
                      id: 'skills-card',
                      child: _SkillGridCard(title: c.t('💪 Skills', '💪 Umiejętności'), items: SiteContent.skills),
                    ),
                    ScrollReveal(
                      id: 'learning-card',
                      delay: const Duration(milliseconds: 120),
                      child: _SkillGridCard(title: c.t('📚 Learning', '📚 W nauce'), items: SiteContent.learning),
                    ),
                  ];
                  if (twoCols) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: cards[0]),
                        const SizedBox(width: 24),
                        Expanded(child: cards[1]),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      cards[0],
                      const SizedBox(height: 20),
                      cards[1],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillGridCard extends StatelessWidget {
  const _SkillGridCard({
    required this.title,
    required this.items,
  });
  final String title;
  final List<SkillItem> items;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 12,
            childAspectRatio: 0.95,
            children: [
              for (final skill in items) _SkillTile(skill: skill),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillTile extends StatefulWidget {
  const _SkillTile({required this.skill});
  final SkillItem skill;

  @override
  State<_SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<_SkillTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final selected = PortfolioScope.of(context).skillFilter == widget.skill.label;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => PortfolioScope.of(context).toggleSkill(widget.skill.label),
        child: AnimatedScale(
          scale: _hovered ? 1.1 : 1,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? AppColors.accent : Colors.transparent,
                width: 1.4,
              ),
              color: selected ? AppColors.accent.withValues(alpha: 0.12) : Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) {
                    Widget icon = Image.asset(
                      widget.skill.iconAsset,
                      width: 42,
                      height: 42,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (_, _, _) =>
                          const Icon(Icons.broken_image, color: Colors.white, size: 36),
                    );
                    if (widget.skill.iconAsset.contains('github')) {
                      icon = ColorFiltered(
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        child: icon,
                      );
                    }
                    return icon;
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  widget.skill.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected ? Colors.white : AppColors.muted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              ScrollReveal(
                id: 'projects-title',
                child: _SectionTitle(c.t('My Projects', 'Moje projekty')),
              ),
              if (c.skillFilter != null) ...[
                const SizedBox(height: 12),
                TextButton(
                  onPressed: c.clearSkill,
                  child: Text(
                    c.t(
                      'Showing projects for ${c.skillFilter}  ·  clear',
                      'Projekty dla ${c.skillFilter}  ·  wyczyść',
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final cols = width > 980 ? 3 : width > 640 ? 2 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: SiteContent.projects.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 16 / 11,
                    ),
                    itemBuilder: (context, index) {
                      final project = SiteContent.projects[index];
                      final filter = c.skillFilter;
                      final matches = filter == null ||
                          SkillMatch.projectUses(filter, project.technologies);
                      return ScrollReveal(
                        id: 'project-${project.id}',
                        delay: Duration(milliseconds: 80 * index),
                        offset: const Offset(-80, 0),
                        child: ProjectCard(project: project, dimmed: !matches),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              ScrollReveal(
                id: 'interests-title',
                child: _SectionTitle(
                  PortfolioScope.of(context).t(
                    'Interests and Soft Skills',
                    'Zainteresowania i kompetencje miękkie',
                  ),
                ),
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  final two = constraints.maxWidth > 800;
                  final left = ScrollReveal(
                    id: 'interests',
                    child: GlassCard(
                      child: Column(
                        children: [
                          const Text(
                            '🎯 Interests',
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20),
                          for (final item in SiteContent.interests)
                            _InterestTile(item: item),
                        ],
                      ),
                    ),
                  );
                  final right = ScrollReveal(
                    id: 'soft',
                    delay: const Duration(milliseconds: 120),
                    child: GlassCard(
                      child: Column(
                        children: [
                          const Text(
                            '🌟 Soft Skills',
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20),
                          for (final item in SiteContent.softSkills)
                            _SoftSkillBar(item: item),
                        ],
                      ),
                    ),
                  );
                  if (two) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: left),
                        const SizedBox(width: 24),
                        Expanded(child: right),
                      ],
                    );
                  }
                  return Column(children: [left, const SizedBox(height: 20), right]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InterestTile extends StatefulWidget {
  const _InterestTile({required this.item});
  final InterestItem item;

  @override
  State<_InterestTile> createState() => _InterestTileState();
}

class _InterestTileState extends State<_InterestTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        margin: const EdgeInsets.only(bottom: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 180,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  widget.item.gifAsset,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  filterQuality: FilterQuality.medium,
                ),
                const ColoredBox(color: Color(0x80000000)),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.item.icon, color: Colors.white, size: 26),
                      const SizedBox(height: 8),
                      Text(
                        widget.item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          shadows: [Shadow(blurRadius: 6, color: Colors.black)],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.item.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          shadows: [Shadow(blurRadius: 6, color: Colors.black)],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SoftSkillBar extends StatelessWidget {
  const _SoftSkillBar({required this.item});
  final SoftSkillItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        children: [
          Row(
            children: [
              Icon(item.icon, color: AppColors.accent, size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Text(item.title, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: item.level,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.footer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
        child: Column(
          children: [
            Text(
              PortfolioScope.of(context).t('Contact', 'Kontakt'),
              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            _ContactLine(
              label: 'Email',
              value: SiteLinks.email,
              url: SiteLinks.mailto,
            ),
            const SizedBox(height: 8),
            _ContactLine(
              label: 'Phone',
              value: SiteLinks.phone,
              url: SiteLinks.tel,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => launchUrl(Uri.parse(SiteLinks.linkedin)),
                  icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
                ),
                IconButton(
                  onPressed: () => launchUrl(Uri.parse(SiteLinks.github)),
                  icon: const FaIcon(FontAwesomeIcons.github, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactLine extends StatelessWidget {
  const _ContactLine({required this.label, required this.value, required this.url});
  final String label;
  final String value;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          children: [
            TextSpan(text: '$label: '),
            TextSpan(text: value, style: const TextStyle(decoration: TextDecoration.underline)),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: AppBreakpoints.isMobile(context) ? 28 : 36,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
