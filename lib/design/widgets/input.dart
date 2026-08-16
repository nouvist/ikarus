import 'package:flutter/services.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';

class Input extends StatefulWidget {
  final bool obscure;
  final TextInputType? type;
  final TextEditingController? controller;

  const Input({super.key, this.obscure = false, this.type, this.controller});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input>
    implements TextSelectionGestureDetectorBuilderDelegate {
  late final _controller = widget.controller ?? TextEditingController();
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

  @override
  void dispose() {
    if (_controller != widget.controller) _controller.dispose();
    super.dispose();
  }

  void _handleHover(PointerHoverEvent event) {
    _position = event.position;
  }

  void _handleTapOutside(PointerUpEvent event) {
    _focus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: .new(maxHeight: 48),
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
                    true => BorderSide(color: Colors.a0, width: 3),
                    false => BorderSide(color: Colors.bro, width: 2),
                  },
                ),
                borderRadius: .circular(8),
              ),
              child: child!,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: .all(color: Colors.bro),
                borderRadius: .circular(8),
              ),
              child: Padding(
                padding: .symmetric(horizontal: 16, vertical: 4),
                child: Center(
                  child: EditableText(
                    key: _key,
                    controller: _controller,
                    focusNode: _focus,
                    keyboardType: widget.type,
                    obscureText: widget.obscure,
                    style: DefaultTextStyle.of(context).style,
                    cursorColor: Colors.fg0,
                    backgroundCursorColor: Colors.fg0,
                    selectionColor: Colors.bg2,
                    contextMenuBuilder: _buildContextMenu,
                    onTapUpOutside: _handleTapOutside,
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
              child: Text('Potong'),
            ),
            ContextMenuItem(
              onTap: () => state.copySelection(.toolbar),
              child: Text('Salin'),
            ),
            ContextMenuItem(
              onTap: () => state.pasteText(.toolbar),
              child: Text('Tempel'),
            ),
          ],
        ),
      ),
    );
  }
}
