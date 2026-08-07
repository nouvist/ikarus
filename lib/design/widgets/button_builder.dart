import 'package:ikarus/design.dart';
import 'package:rxdart/subjects.dart';

typedef ButtonContainerBuilder =
    Widget Function(
      BuildContext context,
      bool isHover,
      bool isTap,
      Widget? child,
    );

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
  final _state = BehaviorSubject.seeded((isHover: false, isTap: false));

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: widget.behavior,
      onEnter: (event) {
        _state.add((isHover: true, isTap: _state.value.isTap));
      },
      onExit: (event) {
        _state.add((isHover: false, isTap: _state.value.isTap));
      },
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: widget.behavior,
        onTapDown: (details) {
          _state.add((isTap: true, isHover: _state.value.isTap));
        },
        onTapUp: (details) {
          _state.add((isTap: false, isHover: _state.value.isTap));
        },
        child: StreamBuilder(
          stream: _state,
          builder: (context, snapshot) => widget.builder(
            context,
            _state.value.isHover,
            _state.value.isTap,
            widget.child,
          ),
        ),
      ),
    );
  }
}
