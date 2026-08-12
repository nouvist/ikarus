import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

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
                Button(child: Icon(Icons.send)),
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
      child: _Vpl(),
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
          Icon(Icons.play_arrow),
          Icon(Icons.pause),
          Icon(Icons.stop),
          Text('Firefox'),
          Text('Chrome'),
          Builder(
            builder: (context) => TitlebarMenu(
              onTap: () => Navigator.of(
                context,
              ).push(DialogRoute(builder: (context) => Dialog())),
              child: Text('NyobaDialog'),
            ),
          ),
        ],
      ),
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
      child: Center(child: Text('Jika 1')),
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
      if (oldIndex < newIndex) newIndex -= 1;
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
          key: ValueKey(('root', child.key!)),
          child: ReorderableDragStartListener(
            index: i,
            child: VplNested(
              key: ValueKey(('nested', child.key!)),
              value: nested,
              child: child,
            ),
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
