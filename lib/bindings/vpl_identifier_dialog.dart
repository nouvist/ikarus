part of 'vpl.dart';

class VplIdentifierDialog extends StatefulWidget {
  final int nested;
  final String current;
  final List<String> existings;

  const VplIdentifierDialog({
    super.key,
    this.nested = 0,
    required this.current,
    required this.existings,
  });

  static PageRoute<String?> route({
    int nested = 0,
    required String current,
    required List<String> existings,
    required VplInheritedData parent,
  }) {
    return DialogRoute(
      builder: (context) => VplInheritedData.inherit(
        parent: parent,
        child: VplIdentifierDialog(
          nested: nested,
          current: current,
          existings: existings,
        ),
      ),
    );
  }

  @override
  State<VplIdentifierDialog> createState() => _VplIdentifierDialogState();
}

class _VplIdentifierDialogState extends State<VplIdentifierDialog> {
  late final _input = TextEditingController()..text = widget.current;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _handleSave([String? text]) {
    final next = (text ?? _input.text).trim();
    if (next.isEmpty) return;
    context.navigator().pop(next);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topLeft,
      child: Padding(
        padding: .only(
          top: 64,
          left: 16 + (widget.nested * 32),
          right: 16,
          bottom: 16,
        ),
        child: ConstrainedBox(
          constraints: const .new(maxWidth: 400, maxHeight: 500),
          child: Container(
            clipBehavior: .antiAlias,
            decoration: BoxDecoration(
              borderRadius: const .all(.circular(16)),
              color: Colors.bg0,
              border: .all(color: Colors.bro),
              boxShadow: Shadows.s0,
            ),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Padding(
                    padding: const .all(16),
                    child: Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: Input(
                            controller: _input,
                            onSubmit: _handleSave,
                          ),
                        ),
                        Button(
                          onTap: _handleSave,
                          child: const Icon(FluentIcons.save_24_regular),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.existings.length,
                    itemBuilder: (context, index) => VplTile(
                      type: .ident,
                      onTap: () => _handleSave(widget.existings[index]),
                      icon: const Icon(FluentIcons.rename_24_regular),
                      child: Text(widget.existings[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
