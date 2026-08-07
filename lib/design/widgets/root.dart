import 'package:ikarus/design.dart';

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
    );
  }

  Widget _buildInherited(BuildContext context, Widget? child) {
    return Directionality(textDirection: .ltr, child: child!);
  }

  PageRoute<T> _buildPageRoute<T>(
    RouteSettings settings,
    WidgetBuilder builder,
  ) {
    return _PageRoute(builder: builder);
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
