import 'package:flutter/services.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';

class Input extends StatefulWidget {
  final TextEditingController controller;
  final bool obscure;
  final TextInputType? type;
  final List<TextInputFormatter>? formatters;
  final ValueChanged<String>? onSubmit;

  const Input({
    super.key,
    required this.controller,
    this.obscure = false,
    this.type,
    this.formatters,
    this.onSubmit,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input>
    implements TextSelectionGestureDetectorBuilderDelegate {
  final _key = GlobalKey<EditableTextState>();
  final _focus = FocusNode();
  late final _gesture = TextSelectionGestureDetectorBuilder(delegate: this);
  var _position = Offset.zero;

  @override
  GlobalKey<EditableTextState> get editableTextKey => _key;

  @override
  bool get forcePressEnabled => false;

  @override
  bool get selectionEnabled => true;

  void _handleHover(PointerHoverEvent event) {
    _position = event.position;
  }

  void _handleTapOutside(PointerUpEvent event) {
    _focus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: ValueKey(_key),
      constraints: const .new(maxHeight: 48),
      child: _gesture.buildGestureDetector(
        child: MouseRegion(
          cursor: SystemMouseCursors.text,
          onHover: _handleHover,
          child: ListenableBuilder(
            listenable: _focus,
            builder: (context, child) => DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: switch (_focus.hasFocus) {
                    true => const BorderSide(color: Colors.a0, width: 3),
                    false => const BorderSide(color: Colors.bro, width: 2),
                  },
                ),
                borderRadius: const .all(.circular(8)),
              ),
              child: child!,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: .all(color: Colors.bro),
                borderRadius: const .all(.circular(8)),
              ),
              child: Padding(
                padding: const .symmetric(horizontal: 16, vertical: 4),
                child: Center(
                  child: EditableText(
                    key: _key,
                    controller: widget.controller,
                    onTapUpOutside: _handleTapOutside,
                    onSubmitted: widget.onSubmit,
                    focusNode: _focus,
                    keyboardType: widget.type,
                    inputFormatters: widget.formatters,
                    obscureText: widget.obscure,
                    style: DefaultTextStyle.of(context).style,
                    cursorColor: Colors.fg0,
                    backgroundCursorColor: Colors.fg0,
                    selectionColor: Colors.bg2,
                    contextMenuBuilder: _buildContextMenu,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContextMenu(BuildContext context, EditableTextState state) {
    return Focus(
      parentNode: _focus,
      child: _gesture.buildGestureDetector(
        child: ContextMenu(
          position:
              _position -
              context.findAncestorElement<Overlay>()!.calculateWidgetOffset()!,
          menus: [
            ContextMenuItem(
              onTap: () => state.cutSelection(.toolbar),
              child: const Text('Potong'),
            ),
            ContextMenuItem(
              onTap: () => state.copySelection(.toolbar),
              child: const Text('Salin'),
            ),
            ContextMenuItem(
              onTap: () => state.pasteText(.toolbar),
              child: const Text('Tempel'),
            ),
          ],
        ),
      ),
    );
  }
}
