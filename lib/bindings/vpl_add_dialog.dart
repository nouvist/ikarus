part of 'vpl.dart';

class VplAddDialog extends StatefulWidget {
  const VplAddDialog({super.key});

  static PageRoute<RawStatementVariant?> route() {
    return DialogRoute(builder: (context) => VplAddDialog());
  }

  @override
  State<VplAddDialog> createState() => _VplAddDialogState();
}

class _VplAddDialogState extends State<VplAddDialog> {
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
          constraints: .new(maxWidth: 400, maxHeight: 500),
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
      VplTile(
        onTap: _createVplHandler(.if_()),
        type: .scope,
        icon: Icon(FluentIcons.document_page_number_24_regular),
        child: Text("Jika"),
      ),
      VplTile(
        onTap: _createVplHandler(.for_()),
        type: .scope,
        icon: Icon(FluentIcons.document_page_number_24_regular),
        child: Text("Selagi"),
      ),
      VplTile(
        onTap: _createVplHandler(.end()),
        type: .scope,
        icon: Icon(FluentIcons.document_page_number_24_regular),
        child: Text("Tutup"),
      ),
      VplTile(
        onTap: _createVplHandler(.variable()),
        type: .assignment,
        icon: Icon(FluentIcons.braces_variable_24_regular),
        child: Text("Variabel"),
      ),
      for (final fn in FnName.values)
        VplTile(
          onTap: _createVplHandler(.call(fn)),
          type: .call,
          icon: Icon(FluentIcons.cube_24_regular),
          child: Text(fn.display()),
        ),
    ];
  }
}
