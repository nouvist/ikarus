import 'package:ikarus/design.dart';

enum ChatBubbleType { user, assistant }

class ChatBubble extends StatelessWidget {
  final ChatBubbleType type;
  const ChatBubble({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth / 8;
        return Padding(
          padding: switch (type) {
            .user => .only(top: 8, left: padding),
            .assistant => .only(top: 8, right: padding),
          },
          child: Column(
            crossAxisAlignment: switch (type) {
              .user => .end,
              .assistant => .start,
            },
            children: [
              Padding(
                padding: const .all(4),
                child: DefaultTextStyle.merge(
                  style: const .new(fontWeight: .bold),
                  child: switch (type) {
                    .user => const Text('Kamu'),
                    .assistant => const Text('Asisten AI'),
                  },
                ),
              ),
              IntrinsicWidth(
                child: Container(
                  padding: const .symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: switch (type) {
                      .user => Colors.bg1,
                      .assistant => Colors.bg0,
                    },
                    border: .all(color: Colors.bro),
                    borderRadius: const .all(.circular(8)),
                  ),
                  child: const Text("lorem ipsum dolor sit amet consectetur"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
