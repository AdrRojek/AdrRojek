import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/content.dart';
import '../state/portfolio_controller.dart';
import '../theme.dart';
import '../util/site_actions.dart';

class CommandPalette extends StatefulWidget {
  const CommandPalette({
    super.key,
    required this.onJump,
  });

  final void Function(String section) onJump;

  @override
  State<CommandPalette> createState() => _CommandPaletteState();
}

class _PaletteItem {
  const _PaletteItem({
    required this.group,
    required this.label,
    required this.icon,
    required this.keywords,
    required this.run,
    this.hint,
  });

  final String group;
  final String label;
  final IconData icon;
  final String keywords;
  final VoidCallback run;
  final String? hint;
}

class _CommandPaletteState extends State<CommandPalette> {
  final _query = TextEditingController();
  final _focus = FocusNode();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _query.dispose();
    _focus.dispose();
    super.dispose();
  }

  List<_PaletteItem> _all(PortfolioController c) {
    void close() => c.setPalette(false);

    return [
      _PaletteItem(
        group: c.t('Jump', 'Skocz'),
        label: c.t('Home', 'Start'),
        icon: Icons.home_outlined,
        keywords: 'home start hero',
        run: () {
          close();
          widget.onJump('home');
        },
      ),
      _PaletteItem(
        group: c.t('Jump', 'Skocz'),
        label: c.t('About', 'O mnie'),
        icon: Icons.person_outline,
        keywords: 'about experience education cv',
        run: () {
          close();
          widget.onJump('about');
        },
      ),
      _PaletteItem(
        group: c.t('Jump', 'Skocz'),
        label: c.t('Skills', 'Umiejętności'),
        icon: Icons.code,
        keywords: 'skills stack flutter swift',
        run: () {
          close();
          widget.onJump('skills');
        },
      ),
      _PaletteItem(
        group: c.t('Jump', 'Skocz'),
        label: c.t('Projects', 'Projekty'),
        icon: Icons.apps_outlined,
        keywords: 'projects work portfolio',
        run: () {
          close();
          widget.onJump('projects');
        },
      ),
      _PaletteItem(
        group: c.t('Jump', 'Skocz'),
        label: c.t('Contact', 'Kontakt'),
        icon: Icons.mail_outline,
        keywords: 'contact email phone hire',
        run: () {
          close();
          widget.onJump('contact');
        },
      ),
      _PaletteItem(
        group: c.t('Recruiter', 'Rekruter'),
        label: c.t('Open 30-second brief', 'Otwórz briefing 30s'),
        icon: Icons.bolt_outlined,
        keywords: 'recruiter brief hire intern cv scan',
        hint: 'R',
        run: () => c.setBrief(true),
      ),
      _PaletteItem(
        group: c.t('Recruiter', 'Rekruter'),
        label: c.t('Copy email', 'Kopiuj e-mail'),
        icon: Icons.copy_outlined,
        keywords: 'email copy contact ${SiteLinks.email}',
        run: () {
          close();
          SiteActions.copy(context, SiteLinks.email, c.t('Email copied', 'Skopiowano e-mail'));
        },
      ),
      _PaletteItem(
        group: c.t('Recruiter', 'Rekruter'),
        label: c.t('Copy phone', 'Kopiuj telefon'),
        icon: Icons.phone_outlined,
        keywords: 'phone copy ${SiteLinks.phone}',
        run: () {
          close();
          SiteActions.copy(context, SiteLinks.phone, c.t('Phone copied', 'Skopiowano telefon'));
        },
      ),
      _PaletteItem(
        group: c.t('Recruiter', 'Rekruter'),
        label: c.t('Write email', 'Napisz e-mail'),
        icon: Icons.send_outlined,
        keywords: 'mailto hire intern',
        run: () {
          close();
          SiteActions.open(SiteLinks.mailto);
        },
      ),
      _PaletteItem(
        group: c.t('Links', 'Linki'),
        label: 'GitHub',
        icon: Icons.code,
        keywords: 'github repos code',
        run: () {
          close();
          SiteActions.open(SiteLinks.github);
        },
      ),
      _PaletteItem(
        group: c.t('Links', 'Linki'),
        label: 'LinkedIn',
        icon: Icons.work_outline,
        keywords: 'linkedin job',
        run: () {
          close();
          SiteActions.open(SiteLinks.linkedin);
        },
      ),
      _PaletteItem(
        group: c.t('Site', 'Strona'),
        label: c.t('Switch language', 'Zmień język'),
        icon: Icons.translate,
        keywords: 'language pl en polish english',
        run: () {
          c.toggleLang();
          close();
        },
      ),
      _PaletteItem(
        group: c.t('Site', 'Strona'),
        label: c.t('Open terminal', 'Otwórz terminal'),
        icon: Icons.terminal,
        keywords: 'terminal cli konami dev',
        hint: '`',
        run: () => c.setTerminal(true),
      ),
      for (final project in SiteContent.projects)
        _PaletteItem(
          group: c.t('Projects', 'Projekty'),
          label: project.title,
          icon: Icons.folder_outlined,
          keywords: '${project.title} ${project.technologies.join(' ')}',
          run: () {
            close();
            widget.onJump('projects');
          },
        ),
    ];
  }

  List<_PaletteItem> _filtered(PortfolioController c) {
    final q = _query.text.trim().toLowerCase();
    final items = _all(c);
    if (q.isEmpty) return items;
    return items.where((item) {
      return item.label.toLowerCase().contains(q) ||
          item.keywords.toLowerCase().contains(q) ||
          item.group.toLowerCase().contains(q);
    }).toList();
  }

  void _move(int delta, int length) {
    if (length == 0) return;
    setState(() => _index = (_index + delta).clamp(0, length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final c = PortfolioScope.of(context);
    final items = _filtered(c);
    if (_index >= items.length) _index = items.isEmpty ? 0 : items.length - 1;

    return Material(
      color: Colors.black.withValues(alpha: 0.55),
      child: GestureDetector(
        onTap: () => c.setPalette(false),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560, maxHeight: 520),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFF111214),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x66000000),
                        blurRadius: 40,
                        offset: Offset(0, 18),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                          child: Focus(
                          onKeyEvent: (node, event) {
                            if (event is! KeyDownEvent) return KeyEventResult.ignored;
                            if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                              _move(1, items.length);
                              return KeyEventResult.handled;
                            }
                            if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                              _move(-1, items.length);
                              return KeyEventResult.handled;
                            }
                            return KeyEventResult.ignored;
                          },
                          child: TextField(
                            controller: _query,
                            focusNode: _focus,
                            onChanged: (_) => setState(() => _index = 0),
                            onSubmitted: (_) {
                              if (items.isNotEmpty) items[_index].run();
                            },
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            cursorColor: AppColors.accent,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search, color: Colors.white54),
                              hintText: c.t(
                                'Jump, copy email, open GitHub…',
                                'Skocz, kopiuj e-mail, otwórz GitHub…',
                              ),
                              hintStyle: const TextStyle(color: Colors.white38),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const Divider(height: 1, color: Colors.white12),
                      Flexible(
                        child: items.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(24),
                                child: Text(
                                  c.t('No matches', 'Brak wyników'),
                                  style: const TextStyle(color: Colors.white54),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                itemCount: items.length,
                                itemBuilder: (context, i) {
                                  final item = items[i];
                                  final selected = i == _index;
                                  final showGroup = i == 0 || items[i - 1].group != item.group;
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (showGroup)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                                          child: Text(
                                            item.group.toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white38,
                                              fontSize: 11,
                                              letterSpacing: 1.1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      Material(
                                        color: selected
                                            ? AppColors.accent.withValues(alpha: 0.22)
                                            : Colors.transparent,
                                        child: ListTile(
                                          dense: true,
                                          leading: Icon(item.icon, color: Colors.white70, size: 18),
                                          title: Text(
                                            item.label,
                                            style: const TextStyle(color: Colors.white, fontSize: 14),
                                          ),
                                          trailing: item.hint == null
                                              ? null
                                              : Text(
                                                  item.hint!,
                                                  style: const TextStyle(
                                                    color: Colors.white38,
                                                    fontFamily: 'monospace',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                          onTap: item.run,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                      const Divider(height: 1, color: Colors.white12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Text(
                          c.t(
                            '↑↓ navigate  ·  Enter run  ·  Esc close',
                            '↑↓ nawigacja  ·  Enter uruchom  ·  Esc zamknij',
                          ),
                          style: const TextStyle(color: Colors.white38, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
