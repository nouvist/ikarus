import 'package:ikarus/design.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _input = TextEditingController();
  final _chat = <ChatBubble>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: switch (_chat.isEmpty) {
            true => const Center(
              child: Text(
                style: .new(color: Colors.fg2),
                'Belum ada percakapan yang kamu mulai.',
              ),
            ),
            false => ListView(
              padding: const .all(8),
              reverse: true,
              children: _chat,
            ),
          },
        ),
        Padding(
          // ignore: prefer_const_constructors
          padding: .only(left: 8, bottom: 8, right: 8),
          child: Row(
            spacing: 8,
            children: [
              Expanded(child: Input(controller: _input)),
              const Button(child: Icon(FluentIcons.send_24_regular)),
            ],
          ),
        ),
      ],
    );
  }
}
