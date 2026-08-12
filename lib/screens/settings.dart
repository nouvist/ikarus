import 'package:ikarus/design.dart';
import 'package:ikarus/extensions/build_context.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                    Button(
                      onTap: () => context.navigator().pop(),
                      child: Text('Batal'),
                    ),
                    Button(child: Text('Simpan')),
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
      Text(
        style: .new(fontSize: 18),
        textAlign: .center,
        'Text Generation Provider',
      ),
      Gap(10),
      Row(
        children: [
          Expanded(child: Text('API URL')),
          Expanded(flex: 2, child: Input()),
        ],
      ),
      Gap(8),
      Row(
        children: [
          Expanded(child: Text('API Key')),
          Expanded(flex: 2, child: Input()),
        ],
      ),
      Gap(8),
      Row(
        children: [
          Expanded(child: Text('Model')),
          Expanded(flex: 2, child: Input()),
        ],
      ),
    ];
  }

  List<Widget> _buildTextEmbeddingProvider(BuildContext context) {
    return [
      Gap(16),
      Text(
        style: .new(fontSize: 18),
        textAlign: .center,
        'Text Embedding Provider',
      ),
      Gap(10),
      Row(
        children: [
          Expanded(child: Text('API URL')),
          Expanded(flex: 2, child: Input()),
        ],
      ),
      Gap(8),
      Row(
        children: [
          Expanded(child: Text('API Key')),
          Expanded(flex: 2, child: Input()),
        ],
      ),
      Gap(8),
      Row(
        children: [
          Expanded(child: Text('Model')),
          Expanded(flex: 2, child: Input()),
        ],
      ),
    ];
  }
}
