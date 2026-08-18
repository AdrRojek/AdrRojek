import 'package:flutter/material.dart';

class PortfolioController extends ChangeNotifier {
  bool polish = false;
  String? skillFilter;

  void toggleLang() {
    polish = !polish;
    notifyListeners();
  }

  void toggleSkill(String label) {
    skillFilter = skillFilter == label ? null : label;
    notifyListeners();
  }

  void clearSkill() {
    if (skillFilter == null) return;
    skillFilter = null;
    notifyListeners();
  }

  String t(String en, String pl) => polish ? pl : en;
}

class PortfolioScope extends InheritedNotifier<PortfolioController> {
  const PortfolioScope({
    super.key,
    required PortfolioController controller,
    required super.child,
  }) : super(notifier: controller);

  static PortfolioController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<PortfolioScope>();
    assert(scope != null, 'PortfolioScope not found');
    return scope!.notifier!;
  }
}

class SkillMatch {
  static bool projectUses(String skill, List<String> technologies) {
    final aliases = <String, List<String>>{
      'swift': ['swift', 'swiftui', 'swiftdata'],
      'kotlin': ['kotlin', 'android'],
      'android studio': ['android', 'kotlin'],
      'php': ['php'],
      'laravel': ['laravel', 'php'],
      'java': ['java'],
      'mysql': ['mysql'],
      'sqlite': ['sqlite'],
      'javascript': ['javascript', 'js', 'bootstrap'],
      'html': ['html', 'bootstrap'],
      'css3': ['css', 'bootstrap'],
      'github': ['git'],
      'python': ['python'],
      'c++': ['c++'],
      'c#': ['c#'],
      'docker': ['docker'],
      'figma': ['figma'],
    };
    final key = skill.toLowerCase();
    final needles = aliases[key] ?? [key];
    return technologies.any((tech) {
      final token = tech.toLowerCase();
      return needles.any((n) {
        if (n.length <= 2) return token == n;
        return token.contains(n);
      });
    });
  }
}
