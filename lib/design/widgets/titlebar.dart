import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';
import 'package:window_manager/window_manager.dart';

class Titlebar extends StatelessWidget {
  final List<Widget>? menus;

  const Titlebar({super.key, this.menus});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: Colors.bg0,
      child: Row(
        crossAxisAlignment: .stretch,
        children: [
          const Gap(16),
          const IkarusLogo(type: .square, width: 24),
          if (menus case final it?) ...[
            const Gap(16),
            Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              spacing: 4,
              children: it,
            ),
          ],
          const Expanded(child: DragToMoveArea(child: SizedBox())),
          const TitlebarChrome(),
        ],
      ),
    );
  }
}

class TitlebarChrome extends StatelessWidget {
  const TitlebarChrome({super.key});

  @override
  Widget build(BuildContext context) {
    return const IntrinsicWidth(
      child: SizedBox(
        height: 48,
        child: Row(
          children: [_Chrome(.minimize), _Chrome(.maximize), _Chrome(.close)],
        ),
      ),
    );
  }
}

class TitlebarMenu extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const TitlebarMenu({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTap: onTap,
      builder: (context, state, child) => Container(
        height: 32,
        alignment: .center,
        padding: const .symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const .all(.circular(4)),
          color: switch (state) {
            .rest => null,
            .hover => Colors.ov1,
            .tap => Colors.ov2,
          },
        ),
        child: Foreground(
          color: switch (state) {
            .hover => Colors.fg0,
            _ => Colors.fg1,
          },
          child: child!,
        ),
      ),
      child: child,
    );
  }
}

enum _ChromeType { close, maximize, minimize }

class _Chrome extends StatefulWidget {
  final _ChromeType type;

  const _Chrome(this.type);

  @override
  State<_Chrome> createState() => _ChromeState();
}

class _ChromeState extends State<_Chrome> with WindowListener {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    WindowManager.instance.addListener(this);
  }

  @override
  void dispose() {
    WindowManager.instance.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    if (widget.type != .maximize) return;
    setState(() => _isMaximized = true);
  }

  @override
  void onWindowUnmaximize() {
    if (widget.type != .maximize) return;
    setState(() => _isMaximized = false);
  }

  Future<void> _handleTap() {
    return switch (widget.type) {
      .close => WindowManager.instance.close(),
      .maximize => switch (_isMaximized) {
        true => WindowManager.instance.unmaximize(),
        false => WindowManager.instance.maximize(),
      },
      .minimize => WindowManager.instance.minimize(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTap: _handleTap,
      behavior: .opaque,
      builder: (context, state, child) => Container(
        width: 46,
        decoration: BoxDecoration(
          color: switch (state) {
            .hover => switch (widget.type == .close) {
              true => const Color(0xffc42b1c),
              false => Colors.ov1,
            },
            _ => const Color(0x00000000),
          },
        ),
        child: child,
      ),
      child: Center(
        child: SvgPicture.asset(
          colorFilter: const .mode(Colors.fg0, .srcIn),
          switch (widget.type) {
            .close => 'assets/chrome/close.svg',
            .maximize => switch (_isMaximized) {
              true => 'assets/chrome/restore.svg',
              false => 'assets/chrome/maximize.svg',
            },
            .minimize => 'assets/chrome/minimize.svg',
          },
        ),
      ),
    );
  }
}
