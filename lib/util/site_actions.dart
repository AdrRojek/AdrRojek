import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SiteActions {
  static Future<void> open(String url) async {
    await launchUrl(Uri.parse(url));
  }

  static Future<void> copy(
    BuildContext context,
    String text,
    String toast,
  ) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(toast),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class WarsawClock {
  static DateTime now() {
    final utc = DateTime.now().toUtc();
    final offsetHours = _isCest(utc) ? 2 : 1;
    return utc.add(Duration(hours: offsetHours));
  }

  static String label() {
    final t = now();
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return '$hh:$mm Warsaw';
  }

  static bool _isCest(DateTime utc) {
    DateTime lastSunday(int year, int month) {
      final last = DateTime.utc(year, month + 1, 0);
      return last.subtract(Duration(days: last.weekday % 7));
    }

    final start = lastSunday(utc.year, 3).add(const Duration(hours: 1));
    final end = lastSunday(utc.year, 10).add(const Duration(hours: 1));
    return !utc.isBefore(start) && utc.isBefore(end);
  }
}
