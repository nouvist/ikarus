import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:ikarus/crux.dart';
import 'package:ikarus/crux/ai/state.dart';
import 'package:ikarus/design.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _input = TextEditingController();
  var _enabled = true;
  late var _chat = _buildInitialChat();

  void _push(List<Widget> children) {
    if (!mounted) return;
    setState(() => _chat = [...children.reversed, ..._chat]);
  }

  Future<void> _handleSubmit() async {
    final ai = await AiSingleton.instance();
    final prompt = _input.text.trim();
    if (prompt.isEmpty) return;

    setState(() {
      _enabled = false;
      _input.clear();
    });

    _push([
      const ChatName(type: .user),
      ChatBubble(type: .user, child: Text(prompt)),
    ]);

    try {
      _push([
        const ChatName(type: .assistant),
        const ChatBubble(type: .assistant, child: Text('Berpikir...')),
      ]);
      await ai.prompt(
        prompt: prompt,
        cb: (data) => switch (data) {
          AiState_Start it => _push([
            switch (it.field0.decision) {
              .answerImmediately => const ChatBubble(
                type: .assistant,
                child: Text('Merangkai jawaban...'),
              ),
              .planForAlgorithm => const ChatBubble(
                type: .assistant,
                child: Text('Merangkai rencana...'),
              ),
            },
          ]),
          AiState_Answer it => _push([
            ChatBubble(type: .assistant, child: Text(it.field0.message)),
          ]),
          AiState_Plan it => _push([
            for (final plan in it.field0.plans)
              ChatBubble(type: .assistant, child: Text(plan)),
          ]),
        },
      );
    } on AnyhowException catch (err) {
      Console.current().log(err.message);
    } finally {
      setState(() => _enabled = true);
    }
  }

  void _handleClear() => setState(() {
    _chat = _buildInitialChat();
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const .all(8),
                  reverse: true,
                  children: _chat,
                ),
              ),
              Padding(
                // ignore: prefer_const_constructors
                padding: .only(left: 8, bottom: 8, right: 8),
                child: Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: Input(
                        enabled: _enabled,
                        controller: _input,
                        onSubmit: (_) => _handleSubmit(),
                      ),
                    ),
                    Button(
                      enabled: _enabled,
                      onTap: _handleSubmit,
                      child: const Icon(FluentIcons.send_24_regular),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 8,
          right: 8,
          child: ClipRRect(
            clipBehavior: .antiAlias,
            child: BackdropFilter(
              filter: .blur(sigmaX: 8, sigmaY: 8),
              child: Button(
                onTap: _handleClear,
                width: 48,
                padding: .zero,
                child: const Icon(FluentIcons.delete_24_regular),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildInitialChat() => [
    const Gap(16),
    const Text(
      textAlign: .center,
      style: .new(color: Colors.fg2),
      'Percakapan tidak bersifat kontinu, setiap pesan memiliki konteks baru.',
    ),
  ];
}
