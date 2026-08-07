import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';
import 'package:window_manager/window_manager.dart';

class Titlebar extends StatelessWidget {
  const Titlebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: Colors.bg0,
      child: Row(
        children: [
          Expanded(
            child: DragToMoveArea(
              child: SizedBox(width: .infinity, height: .infinity),
            ),
          ),
          _Chrome(.minimize),
          _Chrome(.maximize),
          _Chrome(.close),
        ],
      ),
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
      builder: (context, isHover, isTap, child) => Container(
        width: 46,
        decoration: BoxDecoration(
          color: switch (isHover) {
            true => switch (widget.type == .close) {
              true => Color(0xffc42b1c),
              false => Colors.bg1,
            },
            false => Color(0x00000000),
          },
        ),
        child: child,
      ),
      child: Center(
        child: SvgPicture.asset(switch (widget.type) {
          .close => 'assets/chrome/close.svg',
          .maximize => switch (_isMaximized) {
            true => 'assets/chrome/restore.svg',
            false => 'assets/chrome/maximize.svg',
          },
          .minimize => 'assets/chrome/minimize.svg',
        }),
      ),
    );
  }
}
