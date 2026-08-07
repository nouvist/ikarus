import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';
import 'package:window_manager/window_manager.dart';

class Root extends StatelessWidget {
  final Widget home;

  const Root({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      home: home,
      color: Colors.bg0,
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
          Expanded(child: _Splash(child: child!)),
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

class _Splash extends StatefulWidget {
  final Widget child;
  const _Splash({required this.child});

  @override
  State<_Splash> createState() => _SplashState();
}

class _SplashState extends State<_Splash> with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(
    duration: .new(milliseconds: 300),
    vsync: this,
    value: 0,
  );

  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    Timer(const .new(seconds: 3), _handleTimer);
    _animation.addStatusListener(_handleAnimation);
  }

  void _handleTimer() {
    if (!mounted) return;
    _animation.animateTo(1);
  }

  void _handleAnimation(AnimationStatus status) {
    if (!mounted) return;
    if (status != .completed && status != .dismissed) return;
    setState(() => _isDone = true);
  }

  @override
  Widget build(BuildContext context) {
    return switch (_isDone) {
      true => widget.child,
      false => Stack(
        children: [
          Positioned.fill(child: widget.child),
          Positioned.fill(child: _buildSplash()),
        ],
      ),
    };
  }

  Widget _buildSplash() {
    return DragToMoveArea(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) => Opacity(
          opacity: 1 - _animation.value,
          child: ColoredBox(
            color: Colors.bg0,
            child: Transform.translate(
              offset: .new(
                0,
                _animation.value.curve(Curves.easeInCirc).lerp(0, 128),
              ),
              child: child,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(child: Center(child: IkarusLogo(width: 256))),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                height: 64,
                alignment: .center,
                colorFilter: .mode(Colors.border, .srcIn),
                'assets/images/SplashText.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Titlebar extends StatelessWidget {
  const _Titlebar();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.bg0,
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
