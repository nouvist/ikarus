import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  static PageRoute<RawStatementVariant?> route() {
    return DialogRoute(builder: (context) => CreateScreen());
  }

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  void Function() _createVplHandler(RawStatementVariant variant) => () {
    if (!mounted) return;
    context.navigator().pop(variant);
  };

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
                Padding(padding: const .all(16), child: Input()),
                Expanded(child: ListView(children: _buildVpls(context))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildVpls(BuildContext context) {
    return [
      VplBlockTile(
        onTap: _createVplHandler(.if_()),
        type: .scope,
        child: Text("Jika"),
      ),
      VplBlockTile(
        onTap: _createVplHandler(.for_()),
        type: .scope,
        child: Text("Selagi"),
      ),
      VplBlockTile(
        onTap: _createVplHandler(.end()),
        type: .scope,
        child: Text("Tutup"),
      ),
      VplBlockTile(
        onTap: _createVplHandler(.variable()),
        type: .assignment,
        child: Text("Variabel"),
      ),
      VplBlockTile(
        onTap: _createVplHandler(.call(.print)),
        type: .call,
        child: Text("Cetak"),
      ),
    ];
  }
}
