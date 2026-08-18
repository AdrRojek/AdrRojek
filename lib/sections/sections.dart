import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/content.dart';
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
  final _link = LayerLink();
  final _portal = OverlayPortalController();

  void _open() => _portal.show();
  void _close() => _portal.hide();

  void _toggle() {
    if (_portal.isShowing) {
      _close();
    } else {
      _open();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mobile = AppBreakpoints.isMobile(context);
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _portal,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _link,
            showWhenUnlinked: false,
            targetAnchor: widget.preferLeft ? Alignment.centerLeft : Alignment.centerRight,
            followerAnchor: widget.preferLeft ? Alignment.centerRight : Alignment.centerLeft,
            offset: Offset(widget.preferLeft ? -12 : 12, 0),
            child: IgnorePointer(
              child: Material(
                color: const Color(0xFF0B0B0B),
                elevation: 24,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 340, maxHeight: 400),
                  child: Image.asset(widget.image, fit: BoxFit.contain),
                ),
              ),
            ),
          );
        },
        child: MouseRegion(
          onEnter: mobile ? null : (_) => _open(),
          onExit: mobile ? null : (_) => _close(),
          child: GestureDetector(
            onTap: mobile ? _toggle : null,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const ScrollReveal(
                id: 'skills-title',
                child: _SectionTitle('Specializations'),
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  final twoCols = constraints.maxWidth > 800;
                  final cards = [
                    ScrollReveal(
                      id: 'skills-card',
                      child: _SkillGridCard(title: '💪 Skills', items: SiteContent.skills),
                    ),
                    ScrollReveal(
                      id: 'learning-card',
                      delay: const Duration(milliseconds: 120),
                      child: _SkillGridCard(title: '📚 Learning', items: SiteContent.learning),
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.1 : 1,
        duration: const Duration(milliseconds: 200),
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
              style: const TextStyle(color: AppColors.muted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const ScrollReveal(
                id: 'projects-title',
                child: _SectionTitle('My Projects'),
              ),
              const SizedBox(height: 32),
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
                      return ScrollReveal(
                        id: 'project-${project.id}',
                        delay: Duration(milliseconds: 80 * index),
                        offset: const Offset(-80, 0),
                        child: ProjectCard(project: project),
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
              const ScrollReveal(
                id: 'interests-title',
                child: _SectionTitle('Interests and Soft Skills'),
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
        child: Container(
          constraints: const BoxConstraints(minHeight: 170),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(widget.item.gifAsset),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.5),
                BlendMode.darken,
              ),
            ),
          ),
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
            const Text(
              'Contact',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
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
