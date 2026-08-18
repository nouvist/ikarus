part of 'vpl.dart';

class VplAddDialog extends StatefulWidget {
  const VplAddDialog({super.key});

  static PageRoute<RawStatementVariant?> route() {
    return DialogRoute(builder: (context) => const VplAddDialog());
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
        padding: const .all(16),
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
                const Padding(padding: .all(16), child: Input()),
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
        onTap: _createVplHandler(const .if_()),
        type: .scope,
        icon: const Icon(FluentIcons.document_page_number_24_regular),
        child: const Text('Jika'),
      ),
      VplTile(
        onTap: _createVplHandler(const .for_()),
        type: .scope,
        icon: const Icon(FluentIcons.document_page_number_24_regular),
        child: const Text('Selagi'),
      ),
      VplTile(
        onTap: _createVplHandler(const .end()),
        type: .scope,
        icon: const Icon(FluentIcons.document_page_number_24_regular),
        child: const Text('Tutup'),
      ),
      VplTile(
        onTap: _createVplHandler(const .variable()),
        type: .assignment,
        icon: const Icon(FluentIcons.braces_variable_24_regular),
        child: const Text('Variabel'),
      ),
      for (final fn in FnName.values)
        VplTile(
          onTap: _createVplHandler(.call(fn)),
          type: .call,
          icon: const Icon(FluentIcons.cube_24_regular),
          child: Text(fn.display()),
        ),
    ];
  }
}
