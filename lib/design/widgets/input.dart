import 'package:flutter/services.dart';
import 'package:ikarus/design.dart';

class Input extends StatefulWidget {
  final bool enabled;
  final bool obscure;
  final bool multiline;
  final TextEditingController controller;
  final TextInputType? type;
  final List<TextInputFormatter>? formatters;
  final ValueChanged<String>? onSubmit;

  const Input({
    super.key,
    this.enabled = true,
    this.obscure = false,
    this.multiline = false,
    required this.controller,
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
    if (!widget.enabled) _focus.unfocus();
    final style = DefaultTextStyle.of(context).style;
    final lines = switch (widget.multiline) {
      true => 4,
      false => 1,
    };
    final height = switch (widget.multiline) {
      true => (style.fontSize ?? 12) * (style.height ?? 1.5) * lines + 16,
      false => 48.0,
    };

    return IgnorePointer(
      ignoring: !widget.enabled,
      child: Opacity(
        opacity: switch (widget.enabled) {
          true => 1,
          false => 0.5,
        },
        child: SizedBox(
          key: ValueKey(_key),
          height: height,
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
                        true => const .new(color: Colors.a0, width: 3),
                        false => const .new(color: Colors.bro, width: 2),
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
                        maxLines: lines,
                        controller: widget.controller,
                        onTapUpOutside: _handleTapOutside,
                        onSubmitted: widget.onSubmit,
                        focusNode: _focus,
                        keyboardType: widget.type,
                        inputFormatters: widget.formatters,
                        obscureText: widget.obscure,
                        style: style,
                        cursorColor: Colors.fg0,
                        backgroundCursorColor: Colors.fg0,
                        selectionColor: Colors.bg4,
                        contextMenuBuilder: _buildContextMenu,
                      ),
                    ),
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
          position: _position,
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
