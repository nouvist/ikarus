import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';
import 'package:window_manager/window_manager.dart';

class Root extends StatelessWidget {
  final Widget home;

  const Root({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      home: home,
      color: Colors.bg,
      builder: _buildInherited,
      pageRouteBuilder: _buildPageRoute,
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildInherited(BuildContext context, Widget? child) {
    return Directionality(
      textDirection: .ltr,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          _Titlebar(),
          Expanded(child: child!),
        ],
      ),
    );
  }

  PageRoute<T> _buildPageRoute<T>(
    RouteSettings settings,
    WidgetBuilder builder,
  ) {
    return _PageRoute(builder: builder);
  }
}

class _Titlebar extends StatelessWidget {
  const _Titlebar();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.bg,
      child: DragToMoveArea(
        child: Row(
          children: [
            Expanded(child: SizedBox(height: 48)),
            _Chrome(.minimize),
            _Chrome(.maximize),
            _Chrome(.close),
          ],
        ),
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
    return GestureDetector(
      onTap: _handleTap,
      behavior: .opaque,
      child: SizedBox(
        width: 46,
        height: 32,
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
      ),
    );
  }
}

class _PageRoute<T> extends PageRoute<T> {
  @override
  final barrierColor = null;
  @override
  final barrierLabel = null;
  @override
  final maintainState = true;
  @override
  final transitionDuration = Duration(milliseconds: 300);

  final WidgetBuilder builder;

  _PageRoute({required this.builder});

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }
}
