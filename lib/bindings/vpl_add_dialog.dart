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
  final _search = TextEditingController();
  var _searchTimer = null as Timer?;

  @override
  void initState() {
    super.initState();
    _search.addListener(_handleSearch);
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _handleSearch() {
    _searchTimer?.cancel();
    _searchTimer = Timer(const .new(milliseconds: 200), () {
      if (!mounted) return;
      markNeedsBuild();
    });
  }

  VoidCallback _createVplHandler(RawStatementVariant variant) => () {
    if (!mounted) return;
    context.navigator().pop(variant);
  };

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topCenter,
      child: Padding(
        padding: const .only(top: 64, left: 16, right: 16, bottom: 16),
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
                Padding(
                  padding: const .all(16),
                  child: Input(controller: _search),
                ),
                Expanded(child: ListView(children: _buildVpls(context))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildVpls(BuildContext context) {
    final search = _search.text.toLowerCase().trim();
    return [
      if (search.isEmpty) ...[
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
      ],
      for (final fn in FnName.values) ?_buildFunctions(context, fn, search),
      const Gap(16),
    ];
  }

  Widget? _buildFunctions(BuildContext context, FnName fn, String search) {
    final args = fn.args();
    var display = fn.display();
    display += '(';
    for (final arg in args) {
      if (arg != args[0]) display += ', ';
      display += arg;
    }
    display += ')';

    final lowercase = display.toLowerCase();
    if (!lowercase.contains(search)) return null;
    return VplTile(
      onTap: _createVplHandler(.call(fn)),
      type: .call,
      icon: const Icon(FluentIcons.cube_24_regular),
      child: Text(display),
    );
  }
}
