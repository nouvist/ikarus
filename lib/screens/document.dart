import 'package:ikarus/design.dart';

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
        ],
      ),
    );
  }
}

class _Vpl extends StatelessWidget {
  const _Vpl();

  @override
  Widget build(BuildContext context) {
    final children = [
      VplBlock(
        cutout: .start,
        type: .start,
        child: Center(child: Text('Mulai')),
      ),
      VplBlock(
        type: .call,
        child: Center(child: Text('Fungsi 1')),
      ),
      VplScopeStart(child: Center(child: Text('Jika 1'))),
      VplBlock(
        type: .call,
        nested: 1,
        child: Center(child: Text('Fungsi 2')),
      ),
      VplBlock(
        type: .call,
        nested: 1,
        child: Center(child: Text('Fungsi 3')),
      ),
      VplScopeStart(nested: 1, child: Center(child: Text('Jika bersarang 1'))),
      VplBlock(
        type: .call,
        nested: 2,
        child: Center(child: Text('Fungsi 4')),
      ),
      VplScopeEnd(nested: 1),
      VplScopeEnd(),
      VplNewBlock(),
    ];

    final keyed = children
        .map((child) => KeyedSubtree(key: UniqueKey(), child: child))
        .toList();

    return ReorderableList(
      itemCount: keyed.length,
      padding: .all(8),
      onReorderItem: (oldIndex, newIndex) {},
      itemBuilder: (context, index) => keyed[index],
    );
  }
}
