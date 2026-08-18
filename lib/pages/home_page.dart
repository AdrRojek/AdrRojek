import 'package:flutter/material.dart';

import '../sections/sections.dart';
import '../state/portfolio_controller.dart';
import '../theme.dart';
import '../util/site_actions.dart';
import '../widgets/effects.dart';
import '../widgets/portfolio_chrome.dart';

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
  final _interestsKey = GlobalKey();
  final _contactKey = GlobalKey();
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    final max = _scroll.position.maxScrollExtent;
    final next = max <= 0 ? 0.0 : (_scroll.offset / max).clamp(0.0, 1.0);
    if ((next - _progress).abs() > 0.004) {
      setState(() => _progress = next);
    }
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      alignment: 0.08,
    );
  }

  void _jump(String id) {
    switch (id) {
      case 'home':
      case 'start':
      case 'hero':
        _scrollTo(_heroKey);
        break;
      case 'about':
      case 'o mnie':
        _scrollTo(_aboutKey);
        break;
      case 'skills':
        _scrollTo(_skillsKey);
        break;
      case 'projects':
      case 'projekty':
        _scrollTo(_projectsKey);
        break;
      case 'interests':
        _scrollTo(_interestsKey);
        break;
      case 'contact':
      case 'kontakt':
        _scrollTo(_contactKey);
        break;
      default:
        _scrollTo(_projectsKey);
    }
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
    final sections = [
      (c.t('Home', 'Start'), _heroKey),
      (c.t('About', 'O mnie'), _aboutKey),
      (c.t('Skills', 'Umiejętności'), _skillsKey),
      (c.t('Projects', 'Projekty'), _projectsKey),
      (c.t('Interests', 'Zainteresowania'), _interestsKey),
      (c.t('Contact', 'Kontakt'), _contactKey),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CursorGlow(
        child: PortfolioChrome(
          onJump: _jump,
          child: Stack(
            children: [
            const Positioned.fill(child: StarField()),
            CustomScrollView(
              controller: _scroll,
              slivers: [
                SliverToBoxAdapter(
                  child: KeyedSubtree(
                    key: _heroKey,
                    child: HeroSection(onScrollDown: () => _scrollTo(_aboutKey)),
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
                SliverToBoxAdapter(
                  child: KeyedSubtree(key: _interestsKey, child: const InterestsSection()),
                ),
                SliverToBoxAdapter(
                  child: KeyedSubtree(key: _contactKey, child: const ContactSection()),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 2,
                backgroundColor: Colors.transparent,
                color: AppColors.accent,
              ),
            ),
            Positioned(
              top: mobile ? 16 : 18,
              left: 16,
              child: _AvailabilityChip(label: c.t('Open to internships', 'Otwarty na praktyki')),
            ),
            Positioned(
              top: mobile ? 16 : 18,
              right: 16,
              child: _LangToggle(
                polish: c.polish,
                onTap: c.toggleLang,
              ),
            ),
            if (!mobile)
              Positioned(
                right: 14,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _SectionRail(
                    items: sections,
                    onTap: _scrollTo,
                  ),
                ),
              ),
          ],
        ),
        ),
      ),
    );
  }
}

class _AvailabilityChip extends StatelessWidget {
  const _AvailabilityChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
              Text(
                WarsawClock.label(),
                style: const TextStyle(color: Colors.white54, fontSize: 10, fontFamily: 'monospace'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LangToggle extends StatelessWidget {
  const _LangToggle({required this.polish, required this.onTap});
  final bool polish;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Text(
          polish ? 'PL / EN' : 'EN / PL',
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _SectionRail extends StatelessWidget {
  const _SectionRail({required this.items, required this.onTap});
  final List<(String, GlobalKey)> items;
  final Future<void> Function(GlobalKey key) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in items)
            Tooltip(
              message: item.$1,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => onTap(item.$2),
                icon: const Icon(Icons.circle, size: 8, color: Colors.white70),
              ),
            ),
        ],
      ),
    );
  }
}
