import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'state/portfolio_controller.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AdrRojekApp());
}

class AdrRojekApp extends StatefulWidget {
  const AdrRojekApp({super.key});

  @override
  State<AdrRojekApp> createState() => _AdrRojekAppState();
}

class _AdrRojekAppState extends State<AdrRojekApp> {
  final _controller = PortfolioController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortfolioScope(
      controller: _controller,
      child: MaterialApp(
        title: 'Adrian Rojek CV',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: const ColorScheme.dark(
            primary: AppColors.accent,
            surface: AppColors.background,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
