import 'package:flutter/material.dart';

class PortfolioController extends ChangeNotifier {
  bool polish = false;

  void toggleLang() {
    polish = !polish;
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
