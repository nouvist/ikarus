import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _input = TextEditingController();
  var _chat = <Widget>[];

  Future<void> _handleSubmit() async {
    final ai = await AiSingleton.instance();
    final prompt = _input.text.trim();
    if (prompt.isEmpty) return;

    setState(() {
      _input.clear();
      _chat = [
        ChatBubble(type: .user, child: Text(prompt)),
        const ChatName(type: .user),
        ..._chat,
      ];
    });

    final result = await ai.prompt(prompt: prompt);
    if (result case final result?) {
      setState(() {
        _chat = [
          ChatBubble(type: .assistant, child: Text(result)),
          const ChatName(type: .assistant),
          ..._chat,
        ];
      });
    } else {
      setState(() => _chat.removeLast());
    }
  }

  void _handleClear() => setState(() {
    _chat = const [];
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
                        controller: _input,
                        onSubmit: (_) => _handleSubmit(),
                      ),
                    ),
                    Button(
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
          child: Button(
            onTap: _handleClear,
            width: 48,
            padding: .zero,
            child: const Icon(FluentIcons.delete_24_regular),
          ),
        ),
      ],
    );
  }
}
