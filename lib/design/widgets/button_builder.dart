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
  final VoidCallback? onTapUp;
  final VoidCallback? onTapDown;
  final VoidCallback? onDoubleTap;
  final HitTestBehavior? behavior;
  final ButtonContainerBuilder builder;
  final Widget? child;

  const ButtonBuilder({
    super.key,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
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
        behavior: widget.behavior,
        onTap: widget.onTap,
        onDoubleTap: widget.onDoubleTap,
        onTapUp: (details) {
          widget.onTapUp?.call();
          _state.add(switch (_lastHover) {
            true => .hover,
            false => .rest,
          });
        },
        onTapDown: (details) {
          widget.onTapDown?.call();
          _state.add(.tap);
        },
        child: StreamBuilder(
          stream: _state,
          builder: (context, snapshot) =>
              widget.builder(context, _state.value, widget.child),
        ),
      ),
    );
  }
}
