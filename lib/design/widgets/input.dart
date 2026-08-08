import 'package:ikarus/design.dart';

class Input extends StatefulWidget {
  const Input({super.key});
  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input>
    implements TextSelectionGestureDetectorBuilderDelegate {
  final _key = GlobalKey<EditableTextState>();
  final _controller = TextEditingController();
  final _focus = FocusNode();
  late final _gesture = TextSelectionGestureDetectorBuilder(delegate: this);

  @override
  GlobalKey<EditableTextState> get editableTextKey => _key;

  @override
  bool get forcePressEnabled => false;

  @override
  bool get selectionEnabled => true;

  void _handleTapOutside(PointerDownEvent event) {
    _focus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: .new(maxHeight: 48),
      child: _gesture.buildGestureDetector(
        behavior: .opaque,
        child: MouseRegion(
          cursor: SystemMouseCursors.text,
          child: ListenableBuilder(
            listenable: _focus,
            builder: (context, child) => DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: switch (_focus.hasFocus) {
                    true => BorderSide(color: Colors.a0, width: 3),
                    false => BorderSide(
                      color: Colors.border,
                      width: 2,
                    ),
                  },
                ),
                borderRadius: .circular(8),
              ),
              child: child!,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: .all(color: Colors.border),
                borderRadius: .circular(8),
              ),
              child: Padding(
                padding: .symmetric(horizontal: 16, vertical: 4),
                child: Center(
                  child: EditableText(
                    key: _key,
                    controller: _controller,
                    focusNode: _focus,
                    style: DefaultTextStyle.of(context).style,
                    cursorColor: Colors.fg0,
                    backgroundCursorColor: Colors.fg0,
                    selectionColor: Colors.bg2,
                    onTapOutside: _handleTapOutside,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
