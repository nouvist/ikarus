import 'package:ikarus/design.dart';
import 'package:rxdart/subjects.dart';

typedef ButtonContainerBuilder =
    Widget Function(BuildContext context, ButtonState state, Widget? child);

enum ButtonState {
  rest,
  hover,
  tap;

  @pragma('vm:prefer-inline')
  bool get isRest => this == .rest;
  @pragma('vm:prefer-inline')
  bool get isHover => this == .hover;
  @pragma('vm:prefer-inline')
  bool get isTap => this == .tap;
}

class ButtonBuilder extends StatefulWidget {
  final VoidCallback? onTap;
  final HitTestBehavior? behavior;
  final ButtonContainerBuilder builder;
  final Widget? child;

  const ButtonBuilder({
    super.key,
    this.onTap,
    this.behavior,
    required this.builder,
    this.child,
  });

  @override
  State<ButtonBuilder> createState() => _ButtonBuilderState();
}

class _ButtonBuilderState extends State<ButtonBuilder> {
  final _state = BehaviorSubject<ButtonState>.seeded(.rest);
  var _lastHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: widget.behavior,
      onEnter: (event) {
        _lastHover = true;
        _state.add(.hover);
      },
      onExit: (event) {
        _lastHover = false;
        _state.add(.rest);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: widget.behavior,
        onTapDown: (details) => _state.add(.tap),
        onTapUp: (details) => _state.add(switch (_lastHover) {
          true => .hover,
          false => .rest,
        }),
        child: StreamBuilder(
          stream: _state,
          builder: (context, snapshot) =>
              widget.builder(context, _state.value, widget.child),
        ),
      ),
    );
  }
}
