import 'package:ikarus/design.dart';
import 'package:ikarus/helpers.dart';

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
  var _state = ButtonState.rest;
  var _lastHover = false;

  Future<void> _updateState(ButtonState state) async {
    await yieldNow();
    if (!mounted) return;
    setState(() {
      _state = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: MouseRegion(
        hitTestBehavior: widget.behavior,
        onEnter: (event) {
          _lastHover = true;
          _updateState(.hover);
        },
        onExit: (event) {
          _lastHover = false;
          _updateState(.rest);
        },
        child: GestureDetector(
          behavior: widget.behavior,
          onTap: widget.onTap,
          onDoubleTap: widget.onDoubleTap,
          onTapUp: (details) {
            widget.onTapUp?.call();
            _updateState(switch (_lastHover) {
              true => .hover,
              false => .rest,
            });
          },
          onTapDown: (details) {
            widget.onTapDown?.call();
            _updateState(.tap);
          },
          child: widget.builder(context, _state, widget.child),
        ),
      ),
    );
  }
}
