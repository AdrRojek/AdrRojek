import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AdrRojekApp());
}

class AdrRojekApp extends StatelessWidget {
  const AdrRojekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
