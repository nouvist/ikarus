import 'package:ikarus/bindings.dart';
import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';
import 'package:ikarus/screens.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final _idents = <String>[];

  final _statements = <RawStatement>[
    .if_(.new(condition: .static_(.boolean(.new(field0: true))))),
    .variable(
      .new(
        ident: .new(field0: "namavar"),
        value: .string(.new(field0: 'valuenya')),
      ),
    ),
    .variable(
      .new(
        ident: .new(field0: "namavar2"),
        value: .string(.new(field0: 'valuenya')),
      ),
    ),
    .end(),
    .call(.print(.new(content: .string(.new(field0: "Halo Dunia!"))))),
  ];

  void _recalculateIdents([bool shouldUpdate = false]) {
    if (shouldUpdate) return setState(() => _recalculateIdents());
    _idents.clear();
    for (final st in _statements) {
      if (st case RawStatement_Variable it) {
        final next = it.field0.ident.field0;
        if (_idents.contains(next)) continue;
        _idents.add(it.field0.ident.field0);
      }
    }
  }

  void _handleAdd() {
    context.navigator().push(CreateScreen.route());
  }

  void _handleReorder(int oldIndex, int newIndex) => setState(() {
    final item = _statements.removeAt(oldIndex);
    _statements.insert(newIndex, item);
  });

  void _handleDelete(int index) => setState(() {
    _statements.removeAt(index);
  });

  void _handleDuplicate(int index) => setState(() {
    _statements.insert(index + 1, _statements[index].copy());
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Padding(
        padding: .only(left: 8, right: 8, bottom: 8),
        child: Column(
          spacing: 8,
          crossAxisAlignment: .stretch,
          children: [
            _buildToolbar(context),
            Expanded(
              child: Row(
                spacing: 8,
                crossAxisAlignment: .stretch,
                children: [
                  Expanded(child: _buildVpl(context)),
                  Expanded(child: _buildChat(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChat(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: .all(color: Colors.bro),
        borderRadius: .circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(padding: .all(8), children: []),
          ),
          Padding(
            padding: .all(8),
            child: Row(
              spacing: 8,
              children: [
                Expanded(child: Input()),
                Button(child: Icon(FluentIcons.send_24_regular)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVpl(BuildContext context) {
    _recalculateIdents();
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        border: .all(color: Colors.bro),
        borderRadius: .circular(8),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Vpl(
              onReorderItem: _handleReorder,
              onDelete: _handleDelete,
              onDuplicate: _handleDuplicate,
              statements: _statements,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Button(
              onTap: _handleAdd,
              width: 48,
              padding: .zero,
              child: Icon(FluentIcons.add_24_filled),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Container(
      padding: .all(8),
      decoration: BoxDecoration(
        border: .all(color: Colors.bro),
        borderRadius: .circular(8),
      ),
      child: Row(
        spacing: 2,
        children: [
          _ToolbarButton(
            onTap: () async {
              await BrowserFacade.renew();
              BrowserFacade.window()?.focus();
            },
            child: Icon(FluentIcons.new_24_regular),
          ),
          _ToolbarButton(child: Icon(FluentIcons.play_24_regular)),
          _ToolbarButton(child: Icon(FluentIcons.pause_24_regular)),
          _ToolbarButton(child: Icon(FluentIcons.stop_24_regular)),
        ],
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const _ToolbarButton({this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTap: onTap,
      builder: (context, state, child) => Container(
        height: 32,
        width: 32,
        alignment: .center,
        decoration: BoxDecoration(
          borderRadius: .circular(4),
          color: switch (state) {
            .rest => null,
            .hover => Colors.ov1,
            .tap => Colors.ov2,
          },
        ),
        child: Foreground(
          color: switch (state) {
            .hover => Colors.fg0,
            _ => Colors.fg1,
          },
          child: child!,
        ),
      ),
      child: child,
    );
  }
}
