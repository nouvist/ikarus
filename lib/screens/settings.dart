import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions/build_context.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static PageRoute route() {
    return DialogRoute(builder: (context) => const SettingsScreen());
  }

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _textUrl = TextEditingController();
  final _textKey = TextEditingController();
  final _textModel = TextEditingController();

  final _embedUrl = TextEditingController();
  final _embedKey = TextEditingController();
  final _embedModel = TextEditingController();
  final _embedDimensions = TextEditingController();

  @override
  void initState() {
    super.initState();
    yieldNow(() async {
      final current = await AiSettings.current();
      if (!mounted) return;
      setState(() {
        _textUrl.text = current.textUrl;
        _textKey.text = current.textKey;
        _textModel.text = current.textModel;
        _embedUrl.text = current.embedUrl;
        _embedKey.text = current.embedKey;
        _embedModel.text = current.embedModel;
        _embedDimensions.text = current.embedDimensions.toString();
      });
    });
  }

  @override
  void dispose() {
    _textUrl.dispose();
    _textKey.dispose();
    _textModel.dispose();
    _embedUrl.dispose();
    _embedKey.dispose();
    _embedModel.dispose();
    super.dispose();
  }

  void _handleCancel() {
    context.navigator().pop();
  }

  Future<void> _handleSave() async {
    final settings = AiSettings(
      textUrl: _textUrl.text,
      textKey: _textKey.text,
      textModel: _textModel.text,
      embedUrl: _embedUrl.text,
      embedKey: _embedKey.text,
      embedModel: _embedModel.text,
      embedDimensions: int.parse(_embedDimensions.text),
    );

    settings.update();
    if (!mounted) return;
    context.navigator().pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .all(16),
        child: Container(
          constraints: const .new(maxWidth: 800, maxHeight: 600),
          decoration: BoxDecoration(
            borderRadius: const .all(.circular(16)),
            color: Colors.bg0,
            border: .all(color: Colors.bro),
            boxShadow: Shadows.s0,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const .all(16),
                  children: [
                    ..._buildTextGenerationProvider(context),
                    ..._buildTextEmbeddingProvider(context),
                  ],
                ),
              ),
              Container(height: 1, color: Colors.bro),
              Padding(
                padding: const .all(16),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: .end,
                  children: [
                    Button(onTap: _handleCancel, child: const Text('Batal')),
                    Button(onTap: _handleSave, child: const Text('Simpan')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTextGenerationProvider(BuildContext context) {
    return [
      const Text(style: .new(fontSize: 18), 'Text Generation Provider'),
      const Gap(10),
      Row(
        children: [
          const Expanded(child: Text('API URL')),
          Expanded(flex: 2, child: Input(controller: _textUrl)),
        ],
      ),
      const Gap(8),
      Row(
        children: [
          const Expanded(child: Text('API Key')),
          Expanded(flex: 2, child: Input(controller: _textKey, obscure: true)),
        ],
      ),
      const Gap(8),
      Row(
        children: [
          const Expanded(child: Text('Model')),
          Expanded(flex: 2, child: Input(controller: _textModel)),
        ],
      ),
    ];
  }

  List<Widget> _buildTextEmbeddingProvider(BuildContext context) {
    return [
      const Gap(16),
      const Text(style: .new(fontSize: 18), 'Text Embedding Provider'),
      const Gap(10),
      Row(
        children: [
          const Expanded(child: Text('API URL')),
          Expanded(flex: 2, child: Input(controller: _embedUrl)),
        ],
      ),
      const Gap(8),
      Row(
        children: [
          const Expanded(child: Text('API Key')),
          Expanded(flex: 2, child: Input(controller: _embedKey, obscure: true)),
        ],
      ),
      const Gap(8),
      Row(
        children: [
          const Expanded(child: Text('Model')),
          Expanded(flex: 2, child: Input(controller: _embedModel)),
        ],
      ),
      const Gap(8),
      Row(
        children: [
          const Expanded(child: Text('Dimensions')),
          Expanded(
            flex: 2,
            child: Input(type: .number, controller: _embedDimensions),
          ),
        ],
      ),
    ];
  }
}
