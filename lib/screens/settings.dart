import 'package:ikarus/crux/ai/settings.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions/build_context.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

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

    await settings.update();
    if (!mounted) return;
    context.navigator().pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: .all(16),
        child: Container(
          constraints: .new(maxWidth: 800, maxHeight: 600),
          decoration: BoxDecoration(
            borderRadius: .circular(16),
            color: Colors.bg0,
            border: .all(color: Colors.bro),
            boxShadow: Shadows.s0,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: .all(16),
                  children: [
                    ..._buildTextGenerationProvider(context),
                    ..._buildTextEmbeddingProvider(context),
                  ],
                ),
              ),
              Container(height: 1, color: Colors.bro),
              Padding(
                padding: .all(16),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: .end,
                  children: [
                    Button(onTap: _handleCancel, child: Text('Batal')),
                    Button(onTap: _handleSave, child: Text('Simpan')),
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
      Text(style: .new(fontSize: 18), 'Text Generation Provider'),
      Gap(10),
      Row(
        children: [
          Expanded(child: Text('API URL')),
          Expanded(flex: 2, child: Input(controller: _textUrl)),
        ],
      ),
      Gap(8),
      Row(
        children: [
          Expanded(child: Text('API Key')),
          Expanded(flex: 2, child: Input(controller: _textKey)),
        ],
      ),
      Gap(8),
      Row(
        children: [
          Expanded(child: Text('Model')),
          Expanded(flex: 2, child: Input(controller: _textModel)),
        ],
      ),
    ];
  }

  List<Widget> _buildTextEmbeddingProvider(BuildContext context) {
    return [
      Gap(16),
      Text(style: .new(fontSize: 18), 'Text Embedding Provider'),
      Gap(10),
      Row(
        children: [
          Expanded(child: Text('API URL')),
          Expanded(flex: 2, child: Input(controller: _embedUrl)),
        ],
      ),
      Gap(8),
      Row(
        children: [
          Expanded(child: Text('API Key')),
          Expanded(flex: 2, child: Input(controller: _embedKey)),
        ],
      ),
      Gap(8),
      Row(
        children: [
          Expanded(child: Text('Model')),
          Expanded(flex: 2, child: Input(controller: _embedModel)),
        ],
      ),
      Gap(8),
      Row(
        children: [
          Expanded(child: Text('Dimensions')),
          Expanded(
            flex: 2,
            child: Input(type: .number, controller: _embedDimensions),
          ),
        ],
      ),
    ];
  }
}
