import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../state/portfolio_controller.dart';
import '../theme.dart';
import 'command_palette.dart';
import 'dev_terminal.dart';
import 'matrix_rain.dart';
import 'recruiter_brief.dart';

class PortfolioChrome extends StatefulWidget {
  const PortfolioChrome({
    super.key,
    required this.child,
    required this.onJump,
  });

  final Widget child;
  final void Function(String section) onJump;

  @override
  State<PortfolioChrome> createState() => _PortfolioChromeState();
}

class _PortfolioChromeState extends State<PortfolioChrome> {
  late final KonamiListener _konami;
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _konami = KonamiListener(() {
      final c = PortfolioScope.of(context);
      c.unlockDevMode();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(c.t('Dev mode unlocked', 'Odblokowano tryb deweloperski')),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  bool get _typing {
    final primary = FocusManager.instance.primaryFocus;
    return primary?.context?.findAncestorWidgetOfExactType<EditableText>() != null;
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final c = PortfolioScope.of(context);
    final key = event.logicalKey;
    final meta = HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.meta) ||
        HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.metaLeft) ||
        HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.metaRight);
    final ctrl = HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.control) ||
        HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.controlLeft) ||
        HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.controlRight);

    if (!_typing) _konami.handle(event);

    if (key == LogicalKeyboardKey.escape) {
      if (c.paletteOpen || c.briefOpen || c.terminalOpen || c.matrixOn) {
        c.closeOverlays();
        return KeyEventResult.handled;
      }
    }

    if ((meta || ctrl) && key == LogicalKeyboardKey.keyK) {
      c.togglePalette();
      return KeyEventResult.handled;
    }

    if (!_typing && key == LogicalKeyboardKey.slash) {
      c.togglePalette();
      return KeyEventResult.handled;
    }

    if (!_typing && key == LogicalKeyboardKey.backquote) {
      c.toggleTerminal();
      return KeyEventResult.handled;
    }

    if (!_typing && !c.paletteOpen && !c.terminalOpen && key == LogicalKeyboardKey.keyR) {
      c.setBrief(true);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    final mobile = AppBreakpoints.isMobile(context);

    return Focus(
      autofocus: true,
      focusNode: _focus,
      onKeyEvent: _onKey,
      child: Stack(
        children: [
          widget.child,
          if (c.matrixOn) const Positioned.fill(child: MatrixRain()),
          if (!mobile)
            Positioned(
              left: 16,
              bottom: 16,
              child: _HintBar(
                polish: c.polish,
                onSearch: () => c.togglePalette(),
                onBrief: () => c.setBrief(true),
                onTerminal: () => c.toggleTerminal(),
              ),
            ),
          if (mobile)
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton.small(
                backgroundColor: const Color(0xCC111214),
                onPressed: () => c.togglePalette(),
                child: const Icon(Icons.search, color: Colors.white),
              ),
            ),
          if (c.terminalOpen) DevTerminal(onJump: widget.onJump),
          if (c.briefOpen) Positioned.fill(child: RecruiterBrief(onJump: widget.onJump)),
          if (c.paletteOpen) Positioned.fill(child: CommandPalette(onJump: widget.onJump)),
        ],
      ),
    );
  }
}

class _HintBar extends StatelessWidget {
  const _HintBar({
    required this.polish,
    required this.onSearch,
    required this.onBrief,
    required this.onTerminal,
  });

  final bool polish;
  final VoidCallback onSearch;
  final VoidCallback onBrief;
  final VoidCallback onTerminal;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _HintChip(label: polish ? 'Szukaj ⌘K' : 'Search ⌘K', onTap: onSearch),
            _HintChip(label: polish ? 'Brief R' : 'Brief R', onTap: onBrief),
            _HintChip(label: polish ? 'Terminal `' : 'Terminal `', onTap: onTerminal),
          ],
        ),
      ),
    );
  }
}

class _HintChip extends StatelessWidget {
  const _HintChip({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11, fontFamily: 'monospace'),
        ),
      ),
    );
  }
}
