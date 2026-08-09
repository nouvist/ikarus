import 'package:ikarus/design.dart';

class RestartProvider extends StatefulWidget {
  final Widget child;

  const RestartProvider({super.key, required this.child});

  @pragma('vm:prefer-inline')
  static RestartProviderState? maybeOf(BuildContext context) {
    return Inherited.maybeOf<RestartProviderState>(context);
  }

  @pragma('vm:prefer-inline')
  static RestartProviderState of(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  State<RestartProvider> createState() => _RestartProviderState();
}

abstract class RestartProviderState {
  void restart();
}

class _RestartProviderState extends State<RestartProvider>
    implements RestartProviderState {
  var _key = UniqueKey();

  @override
  void restart() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Inherited<RestartProviderState>(
      value: this,
      child: KeyedSubtree(key: _key, child: widget.child),
    );
  }
}
