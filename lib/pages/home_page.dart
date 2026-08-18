import 'package:flutter/material.dart';

import '../sections/sections.dart';
import '../state/portfolio_controller.dart';
import '../theme.dart';
import '../util/site_actions.dart';
import '../data/content.dart';
import '../widgets/effects.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scroll = ScrollController();
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      alignment: 0.08,
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    final mobile = AppBreakpoints.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: StarField()),
          CustomScrollView(
            controller: _scroll,
            slivers: [
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _heroKey,
                  child: HeroSection(onSeeWork: () => _scrollTo(_projectsKey)),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(key: _aboutKey, child: const InfoSection()),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(key: _skillsKey, child: const SkillsSection()),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(key: _projectsKey, child: const ProjectsSection()),
              ),
              const SliverToBoxAdapter(child: InterestsSection()),
              SliverToBoxAdapter(
                child: KeyedSubtree(key: _contactKey, child: const ContactSection()),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _TopBar(
              polish: c.polish,
              onLang: c.toggleLang,
              onAbout: () => _scrollTo(_aboutKey),
              onProjects: () => _scrollTo(_projectsKey),
              onContact: () => _scrollTo(_contactKey),
              compact: mobile,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _HireBar(compact: mobile),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.polish,
    required this.onLang,
    required this.onAbout,
    required this.onProjects,
    required this.onContact,
    required this.compact,
  });

  final bool polish;
  final VoidCallback onLang;
  final VoidCallback onAbout;
  final VoidCallback onProjects;
  final VoidCallback onContact;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    return Material(
      color: const Color(0xCC000000),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.circle, size: 8, color: Color(0xFF22C55E)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  c.t('Open to internships', 'Otwarty na praktyki'),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              if (!compact) ...[
                TextButton(onPressed: onAbout, child: Text(c.t('Experience', 'Doświadczenie'))),
                TextButton(onPressed: onProjects, child: Text(c.t('Work', 'Projekty'))),
                TextButton(onPressed: onContact, child: Text(c.t('Contact', 'Kontakt'))),
              ],
              TextButton(
                onPressed: onLang,
                child: Text(
                  polish ? 'PL / EN' : 'EN / PL',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HireBar extends StatelessWidget {
  const _HireBar({required this.compact});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    return Material(
      color: const Color(0xF2101114),
      elevation: 16,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () => SiteActions.copy(
                    context,
                    SiteLinks.email,
                    c.t('Email copied', 'Skopiowano e-mail'),
                  ),
                  child: Text(c.t('Copy email', 'Kopiuj e-mail')),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () => SiteActions.open(SiteLinks.mailto),
                  child: Text(c.t('Write email', 'Napisz e-mail')),
                ),
              ),
              if (!compact) ...[
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => SiteActions.open(SiteLinks.linkedin),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                  child: const Text('LinkedIn'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
