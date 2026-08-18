import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../data/content.dart';
import '../state/portfolio_controller.dart';
import '../theme.dart';
import '../util/site_actions.dart';
import '../widgets/effects.dart';
import '../widgets/hanging_flip_card.dart';
import '../widgets/project_widgets.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onSeeWork});
  final VoidCallback onSeeWork;

  @override
  Widget build(BuildContext context) {
    final mobile = AppBreakpoints.isMobile(context);
    final copy = _HeroCopy(onSeeWork: onSeeWork);

    return Padding(
      padding: EdgeInsets.fromLTRB(20, mobile ? 88 : 96, 20, 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: mobile
              ? Column(
                  children: [
                    copy,
                    const SizedBox(height: 28),
                    const RepaintBoundary(child: HangingFlipCard()),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: copy),
                    const SizedBox(width: 24),
                    const RepaintBoundary(child: HangingFlipCard()),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.onSeeWork});
  final VoidCallback onSeeWork;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _Pill(
              icon: Icons.circle,
              iconColor: const Color(0xFF22C55E),
              text: c.t('Open to internships', 'Otwarty na praktyki'),
            ),
            _Pill(text: SiteContent.location),
            _Pill(text: c.t('English C1 · German B1', 'Angielski C1 · Niemiecki B1')),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          SiteContent.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.w800,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${c.t(SiteContent.title, 'Student informatyki')}  ·  ${SiteContent.stack}',
          style: const TextStyle(color: Colors.white70, fontSize: 18, height: 1.35),
        ),
        const SizedBox(height: 16),
        Text(
          c.t(SiteContent.pitchEn, SiteContent.pitchPl),
          style: const TextStyle(color: AppColors.muted, fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: () => SiteActions.copy(
                context,
                SiteLinks.email,
                c.t('Email copied', 'Skopiowano e-mail'),
              ),
              icon: const Icon(Icons.copy, size: 16),
              label: Text(c.t('Copy email', 'Kopiuj e-mail')),
            ),
            FilledButton.tonalIcon(
              onPressed: () => SiteActions.open(SiteLinks.mailto),
              icon: const Icon(Icons.mail_outline, size: 16),
              label: Text(c.t('Write email', 'Napisz e-mail')),
            ),
            OutlinedButton.icon(
              onPressed: () => SiteActions.open(SiteLinks.linkedin),
              icon: const FaIcon(FontAwesomeIcons.linkedin, size: 14),
              label: const Text('LinkedIn'),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            ),
            OutlinedButton.icon(
              onPressed: onSeeWork,
              icon: const Icon(Icons.work_outline, size: 16),
              label: Text(c.t('See work', 'Zobacz projekty')),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, this.icon, this.iconColor});
  final String text;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: iconColor ?? Colors.white70),
            const SizedBox(width: 6),
          ],
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    final featured = SiteContent.experience.where((e) => e.featured).toList();
    final other = SiteContent.experience.where((e) => !e.featured).toList();
    final mobile = AppBreakpoints.isMobile(context);

    final timeline = GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            c.t('Relevant experience', 'Doświadczenie IT'),
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 18),
          for (final role in featured) _TimelineRow(role: role),
          const SizedBox(height: 22),
          Text(
            c.t('Other work', 'Inna praca'),
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          for (final role in other)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '${role.role} — ${role.company}  ·  ${role.dates}',
                style: const TextStyle(color: AppColors.muted, height: 1.4),
              ),
            ),
        ],
      ),
    );

    final side = Column(
      children: [
        _InfoCard(
          title: c.t('Education', 'Wykształcenie'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [for (final item in SiteContent.education) _Bullet(item)],
          ),
        ),
        const SizedBox(height: 16),
        _InfoCard(
          title: c.t('Languages', 'Języki'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [for (final item in SiteContent.languages) _Bullet(item)],
          ),
        ),
        const SizedBox(height: 16),
        _InfoCard(
          title: c.t('Certificates', 'Certyfikaty'),
          child: Column(
            children: [
              for (final cert in SiteContent.certificates)
                PreviewHover(
                  image: cert.image,
                  landscape: true,
                  child: _Bullet(cert.title, trailing: const Text('📜')),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _InfoCard(
          title: c.t('Professional exams', 'Egzaminy zawodowe'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('EE.08 · EE.09', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                c.t(
                  'Systems, networks, security · web apps, databases, deployment.',
                  'Systemy, sieci, bezpieczeństwo · aplikacje web, bazy, wdrożenia.',
                ),
                style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 12),
              const Center(
                child: PreviewHover(
                  image: 'assets/photos/dyplom.png',
                  preferLeft: true,
                  child: SizedBox(
                    width: 28,
                    child: Image(image: AssetImage('assets/photos/dyplom.png')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: mobile
              ? Column(
                  children: [
                    ScrollReveal(id: 'exp', child: timeline),
                    const SizedBox(height: 16),
                    ScrollReveal(id: 'side', child: side),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: ScrollReveal(id: 'exp', child: timeline)),
                    const SizedBox(width: 20),
                    Expanded(flex: 4, child: ScrollReveal(id: 'side', child: side)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.role});
  final RoleItem role;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role.role,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  '${role.company}  ·  ${role.dates}',
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
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
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(color: AppColors.accent, fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.muted, height: 1.4))),
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
    this.landscape = false,
  });

  final String image;
  final Widget child;
  final bool preferLeft;
  final bool landscape;

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
    final previewW = widget.landscape ? 520.0 : 320.0;
    final previewH = widget.landscape ? 380.0 : 400.0;
    _entry = OverlayEntry(
      builder: (context) {
        final screen = MediaQuery.sizeOf(context);
        var left = widget.preferLeft ? origin.dx - previewW - 16 : origin.dx + size.width + 16;
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
              color: Colors.white,
              elevation: 32,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                filterQuality: FilterQuality.medium,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            children: [
              _SectionTitle(c.t('Specializations', 'Specjalizacje')),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final two = constraints.maxWidth > 800;
                  final left = _SkillGridCard(title: c.t('Skills', 'Umiejętności'), items: SiteContent.skills);
                  final right = _SkillGridCard(title: c.t('Learning', 'W nauce'), items: SiteContent.learning);
                  if (two) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: left),
                        const SizedBox(width: 20),
                        Expanded(child: right),
                      ],
                    );
                  }
                  return Column(children: [left, const SizedBox(height: 16), right]);
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
  const _SkillGridCard({required this.title, required this.items});
  final String title;
  final List<SkillItem> items;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            children: [
              for (final skill in items) _SkillTile(skill: skill),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillTile extends StatelessWidget {
  const _SkillTile({required this.skill});
  final SkillItem skill;

  @override
  Widget build(BuildContext context) {
    Widget icon = Image.asset(
      skill.iconAsset,
      width: 36,
      height: 36,
      filterQuality: FilterQuality.medium,
      errorBuilder: (_, _, _) => const Icon(Icons.broken_image, color: Colors.white, size: 32),
    );
    if (skill.iconAsset.contains('github')) {
      icon = ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        child: icon,
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: 8),
        Text(
          skill.label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.muted, fontSize: 12),
        ),
      ],
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            children: [
              _SectionTitle(c.t('My Projects', 'Moje projekty')),
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
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: cols == 1 ? 0.92 : 0.78,
                    ),
                    itemBuilder: (context, index) {
                      return ProjectCard(project: SiteContent.projects[index]);
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
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            children: [
              _SectionTitle(
                PortfolioScope.of(context).t(
                  'Interests and Soft Skills',
                  'Zainteresowania i kompetencje miękkie',
                ),
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  final two = constraints.maxWidth > 800;
                  final left = GlassCard(
                    child: Column(
                      children: [
                        const Text(
                          '🎯 Interests',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        for (final item in SiteContent.interests) _InterestTile(item: item),
                      ],
                    ),
                  );
                  final right = GlassCard(
                    child: Column(
                      children: [
                        const Text(
                          '🌟 Soft Skills',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        for (final item in SiteContent.softSkills) _SoftSkillBar(item: item),
                      ],
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
    final c = PortfolioScope.of(context);
    return ColoredBox(
      color: AppColors.footer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 48, 20, 96),
        child: Column(
          children: [
            Text(
              c.t('Let’s talk internships', 'Porozmawiajmy o praktykach'),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              c.t(
                'Rzeszów · usually reply the same day.',
                'Rzeszów · zwykle odpisuję tego samego dnia.',
              ),
              style: const TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 22),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: () => SiteActions.copy(
                    context,
                    SiteLinks.email,
                    c.t('Email copied', 'Skopiowano e-mail'),
                  ),
                  icon: const Icon(Icons.copy, size: 16),
                  label: Text(SiteLinks.email),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => SiteActions.open(SiteLinks.tel),
                  icon: const Icon(Icons.phone, size: 16),
                  label: Text(SiteLinks.phone),
                ),
                OutlinedButton.icon(
                  onPressed: () => SiteActions.open(SiteLinks.linkedin),
                  icon: const FaIcon(FontAwesomeIcons.linkedin, size: 14),
                  label: const Text('LinkedIn'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                ),
                OutlinedButton.icon(
                  onPressed: () => SiteActions.open(SiteLinks.github),
                  icon: const FaIcon(FontAwesomeIcons.github, size: 14),
                  label: const Text('GitHub'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                ),
              ],
            ),
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
        fontSize: AppBreakpoints.isMobile(context) ? 28 : 34,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
