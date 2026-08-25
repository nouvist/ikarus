import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _input = TextEditingController();
  // final _chat = <ChatBubble>[];

  Future<void> _handleSubmit() async {
    final ai = await AiSingleton.instance();
    final prompt = _input.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const .all(8),
            reverse: true,
            children: const [
              ChatBubble(type: .assistant, child: Text('halo')),
              ChatBubble(type: .assistant, child: Text('halo')),
              ChatName(type: .assistant),
              ChatBubble(type: .user, child: Text('halo')),
              ChatName(type: .user),
            ],
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
    );
  }
}
