part of 'vpl.dart';

class VplIdentDialog extends StatefulWidget {
  final String current;
  final List<String> existings;

  const VplIdentDialog({
    super.key,
    required this.current,
    required this.existings,
  });

  static PageRoute<String?> route({
    required String current,
    required List<String> existings,
  }) {
    return DialogRoute(
      builder: (context) =>
          VplIdentDialog(current: current, existings: existings),
    );
  }

  @override
  State<VplIdentDialog> createState() => _VplIdentDialogState();
}

class _VplIdentDialogState extends State<VplIdentDialog> {
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
    return Center(
      child: Padding(
        padding: .all(16),
        child: ConstrainedBox(
          constraints: .new(maxWidth: 400, maxHeight: 600),
          child: Container(
            clipBehavior: .antiAlias,
            decoration: BoxDecoration(
              borderRadius: .circular(16),
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
                          child: Icon(FluentIcons.save_24_regular),
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
                      onTap: () => _input.text = widget.existings[index],
                      icon: Icon(FluentIcons.rename_24_regular),
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
