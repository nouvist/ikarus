import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';
import 'package:ikarus/helpers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static PageRoute route() {
    return DialogRoute(builder: (context) => const SettingsScreen());
  }

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _url = TextEditingController();
  final _key = TextEditingController();
  final _model = TextEditingController();

  @override
  void initState() {
    super.initState();
    yieldNow(() async {
      final settings = await Settings.current();
      _url.text = settings.textGenerationUrl;
      _key.text = settings.textGenerationKey;
      _model.text = settings.textGenerationModel;
    });
  }

  void _handleCancel() {
    context.navigator().pop();
  }

  Future<void> _handleSave() async {
    final settings = Settings(
      textGenerationUrl: _url.text,
      textGenerationKey: _key.text,
      textGenerationModel: _model.text,
    );

    await settings.save();
    if (!mounted) return;
    context.navigator().pop();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topCenter,
      child: Padding(
        padding: const .only(top: 64, left: 16, right: 16, bottom: 16),
        child: Container(
          constraints: const .new(maxWidth: 400, maxHeight: 500),
          padding: const .all(16),
          clipBehavior: .antiAlias,
          decoration: BoxDecoration(
            borderRadius: const .all(.circular(16)),
            color: Colors.bg0,
            border: .all(color: Colors.bro),
            boxShadow: Shadows.s0,
          ),
          child: IntrinsicHeight(
            child: Column(
              spacing: 8,
              crossAxisAlignment: .stretch,
              children: [
                const Expanded(child: Text('Text Generation Provider')),
                Row(
                  children: [
                    const Expanded(child: Text('API URL')),
                    Expanded(flex: 2, child: Input(controller: _url)),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(child: Text('API Key')),
                    Expanded(
                      flex: 2,
                      child: Input(controller: _key, obscure: true),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Model')),
                    Expanded(flex: 2, child: Input(controller: _model)),
                  ],
                ),
                Padding(
                  padding: const .symmetric(vertical: 8),
                  child: Container(height: 1, color: Colors.bro),
                ),
                const Text('Perubahan memerlukan Ikarus untuk dimulai ulang.'),
                Row(
                  spacing: 8,
                  mainAxisAlignment: .end,
                  children: [
                    Button(onTap: _handleCancel, child: const Text('Batal')),
                    Button(onTap: _handleSave, child: const Text('Simpan')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
