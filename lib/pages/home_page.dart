import 'package:flutter/material.dart';

import '../sections/sections.dart';
import '../theme.dart';
import '../widgets/effects.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scroll = ScrollController();

  void _scrollToInfo() {
    _scroll.animateTo(
      MediaQuery.sizeOf(context).height * 0.92,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CursorGlow(
        child: Stack(
          children: [
            const Positioned.fill(child: StarField()),
            CustomScrollView(
              controller: _scroll,
              slivers: [
                SliverToBoxAdapter(child: HeroSection(onScrollDown: _scrollToInfo)),
                const SliverToBoxAdapter(child: InfoSection()),
                const SliverToBoxAdapter(child: SkillsSection()),
                const SliverToBoxAdapter(child: ProjectsSection()),
                const SliverToBoxAdapter(child: InterestsSection()),
                const SliverToBoxAdapter(child: ContactSection()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
