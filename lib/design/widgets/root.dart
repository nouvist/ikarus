import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';
import 'package:window_manager/window_manager.dart';

class Root extends StatelessWidget {
  final Future<void>? waitFor;
  final Widget? titlebar;
  final Widget home;

  const Root({super.key, this.waitFor, this.titlebar, required this.home});

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
      child: DefaultTextStyle(
        style: Typography.body.copyWith(color: Colors.fg0),
        child: IconTheme(
          data: .new(color: Colors.fg0),
          child: _Splash(
            waitFor: waitFor ?? yieldNow(),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                ?titlebar,
                Expanded(child: child!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PageRoute<T> _buildPageRoute<T>(
    RouteSettings settings,
    WidgetBuilder builder,
  ) {
    return ScreenRoute(builder: builder);
  }
}

class _Splash extends StatefulWidget {
  final Future<void> waitFor;
  final Widget child;

  const _Splash({required this.waitFor, required this.child});

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
    widget.waitFor.then(_handleTimer);
    _animation.addStatusListener(_handleAnimation);
  }

  void _handleTimer(_) {
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
          Positioned(right: 0, top: 0, child: TitlebarChrome()),
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
                colorFilter: .mode(Colors.fg2, .srcIn),
                'assets/images/SplashText.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenRoute<T> extends PageRoute<T> {
  @override
  final barrierColor = null;
  @override
  final barrierLabel = null;
  @override
  final maintainState = true;
  @override
  final transitionDuration = Duration.zero;

  final WidgetBuilder builder;

  ScreenRoute({required this.builder});

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }
}

class DialogRoute<T> extends PageRoute<T> {
  @override
  final barrierColor = Colors.bg0.withAlpha(128);
  @override
  final barrierLabel = null;
  @override
  final maintainState = true;
  @override
  final transitionDuration = Duration(milliseconds: 300);
  @override
  final opaque = false;
  @override
  final bool barrierDismissible;

  final WidgetBuilder builder;

  DialogRoute({required this.builder, this.barrierDismissible = true});

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.translate(
        offset: .new(0, animation.value.curve(Curves.easeOutCirc).lerp(128, 0)),
        child: Opacity(
          opacity: animation.value.invlerp(0, 0.2).clampd(),
          child: child!,
        ),
      ),
      child: BackdropFilter(
        filter: .blur(sigmaX: 4, sigmaY: 4, tileMode: .mirror),
        child: builder(context),
      ),
    );
  }
}
