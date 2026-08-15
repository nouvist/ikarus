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
  void _handleAdd() {
    context.navigator().push(CreateScreen.route());
  }

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
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        border: .all(color: Colors.bro),
        borderRadius: .circular(8),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: _Vpl()),
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
            child: Icon(FluentIcons.new_24_regular)),
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

class _Vpl extends StatefulWidget {
  const _Vpl();

  @override
  State<_Vpl> createState() => _VplState();
}

class _VplState extends State<_Vpl> {
  final _children = <Widget>[
    VplBlock(
      key: UniqueKey(),
      cutout: .start,
      type: .start,
      child: Center(child: Text('Mulai')),
    ),
    VplBlock(
      key: UniqueKey(),
      type: .call,
      child: Center(child: Text('Fungsi 1')),
    ),
    VplScopeStart(
      key: UniqueKey(),
      child: Center(
        child: Row(children: [Text('Jika 1'), Gap(8), VplVariable()]),
      ),
    ),
    VplBlock(
      key: UniqueKey(),
      type: .call,
      child: Center(child: Text('Fungsi 2')),
    ),
    VplBlock(
      key: UniqueKey(),
      type: .call,
      child: Center(child: Text('Fungsi 3')),
    ),
    VplScopeStart(
      key: UniqueKey(),
      child: Center(child: Text('Jika bersarang 1')),
    ),
    VplBlock(
      key: UniqueKey(),
      type: .call,
      child: Center(child: Text('Fungsi 4')),
    ),
    VplScopeEnd(key: UniqueKey()),
    VplScopeEnd(key: UniqueKey()),
  ];

  void _handleReorder(int oldIndex, int newIndex) {
    if (newIndex == 0) newIndex = 1;
    setState(() {
      final item = _children.removeAt(oldIndex);
      _children.insert(newIndex, item);
    });
  }

  List<Widget> _buildNested() {
    var nested = 0;
    final children = <Widget>[];
    for (var i = 0; i < _children.length; i++) {
      final child = _children[i];
      if (child is VplScopeEnd) nested -= 1;
      if (child case VplBlock(type: .start)) {
        children.add(child);
        continue;
      }

      children.add(
        KeyedSubtree(
          key: ValueKey(child.key!),
          child: ReorderableDragStartListener(
            index: i,
            child: VplNested(value: nested, child: child),
          ),
        ),
      );

      if (child is VplScopeStart) nested += 1;
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    final children = _buildNested();

    return ReorderableList(
      itemCount: children.length,
      padding: .all(8),
      onReorderItem: _handleReorder,
      itemBuilder: (context, index) => children[index],
    );
  }
}
