import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/content.dart';
import '../state/portfolio_controller.dart';
import '../theme.dart';
import '../util/site_actions.dart';

class DevTerminal extends StatefulWidget {
  const DevTerminal({super.key, required this.onJump});

  final void Function(String section) onJump;

  @override
  State<DevTerminal> createState() => _DevTerminalState();
}

class _DevTerminalState extends State<DevTerminal> {
  final _input = TextEditingController();
  final _focus = FocusNode();
  final _lines = <String>[
    'adrrojek@cv:~\$ whoami',
    'Adrian Rojek — CS student, Flutter / SwiftUI / Kotlin',
    'Type help. Hidden: Konami ↑↑↓↓←→←→BA',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _input.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _run(String raw) {
    final cmd = raw.trim().toLowerCase();
    final c = PortfolioScope.of(context);
    setState(() => _lines.add('adrrojek@cv:~\$ $raw'));
    if (cmd.isEmpty) return;

    switch (cmd) {
      case 'help':
        _lines.addAll([
          'whoami, ls, skills, contact, hire, brief, lang, matrix, clear, exit',
        ]);
        break;
      case 'whoami':
        _lines.addAll([
          SiteContent.name,
          c.t(SiteContent.title, 'Student informatyki'),
          'Open to internships · ${WarsawClock.label()}',
        ]);
        break;
      case 'ls':
      case 'projects':
        for (final p in SiteContent.projects) {
          _lines.add('  ${p.id}. ${p.title}');
        }
        break;
      case 'skills':
        _lines.add(SiteContent.skills.map((s) => s.label).join(' · '));
        break;
      case 'contact':
        _lines.add('${SiteLinks.email}  ·  ${SiteLinks.phone}');
        break;
      case 'hire':
        _lines.add('Opening mail client…');
        SiteActions.open(SiteLinks.mailto);
        break;
      case 'brief':
        c.setBrief(true);
        break;
      case 'lang':
        c.toggleLang();
        _lines.add(c.polish ? 'PL' : 'EN');
        break;
      case 'matrix':
        c.unlockDevMode();
        _lines.add('wake up, recruiter…');
        break;
      case 'clear':
        _lines
          ..clear()
          ..add('adrrojek@cv:~');
        break;
      case 'exit':
        c.setTerminal(false);
        break;
      case 'github':
        SiteActions.open(SiteLinks.github);
        break;
      case 'linkedin':
        SiteActions.open(SiteLinks.linkedin);
        break;
      default:
        if (cmd.startsWith('cd ')) {
          widget.onJump(cmd.substring(3).trim());
          _lines.add('scrolled.');
        } else {
          _lines.add('command not found: $raw  (try help)');
        }
    }
    _input.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    final mobile = AppBreakpoints.isMobile(context);
    return Positioned(
      left: 16,
      bottom: mobile ? 16 : 52,
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: mobile ? MediaQuery.sizeOf(context).width - 32 : 420,
            maxHeight: mobile ? 280 : 320,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xF2080A0C),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF22C55E).withValues(alpha: 0.45)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 4, 4),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8, color: Color(0xFF22C55E)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          c.devUnlocked ? 'root@adrrojek' : 'guest@adrrojek',
                          style: const TextStyle(
                            color: Color(0xFF86EFAC),
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () => c.setTerminal(false),
                        icon: const Icon(Icons.close, size: 16, color: Colors.white54),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      for (final line in _lines)
                        Text(
                          line,
                          style: const TextStyle(
                            color: Color(0xFFBBF7D0),
                            fontFamily: 'monospace',
                            fontSize: 12,
                            height: 1.45,
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
                  child: Row(
                    children: [
                      const Text(
                        '\$ ',
                        style: TextStyle(color: Color(0xFF22C55E), fontFamily: 'monospace'),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _input,
                          focusNode: _focus,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontSize: 13,
                          ),
                          cursorColor: const Color(0xFF22C55E),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'help',
                            hintStyle: TextStyle(color: Colors.white24, fontFamily: 'monospace'),
                          ),
                          onSubmitted: _run,
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

class KonamiListener {
  KonamiListener(this.onUnlock);

  final VoidCallback onUnlock;
  final _buf = <LogicalKeyboardKey>[];
  static const _seq = [
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.keyB,
    LogicalKeyboardKey.keyA,
  ];

  void handle(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    _buf.add(event.logicalKey);
    if (_buf.length > _seq.length) _buf.removeAt(0);
    if (_buf.length == _seq.length) {
      var ok = true;
      for (var i = 0; i < _seq.length; i++) {
        if (_buf[i] != _seq[i]) {
          ok = false;
          break;
        }
      }
      if (ok) {
        _buf.clear();
        onUnlock();
      }
    }
  }
}
