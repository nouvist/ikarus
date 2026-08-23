import 'package:ikarus/design.dart';

enum ChatType { user, assistant }

class ChatBubble extends StatelessWidget {
  final ChatType type;
  final Widget child;
  const ChatBubble({super.key, required this.type, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth / 8;
        return Padding(
          padding: switch (type) {
            .user => .only(top: 4, left: padding),
            .assistant => .only(top: 4, right: padding),
          },
          child: Align(
            alignment: switch (type) {
              .user => .centerRight,
              .assistant => .centerLeft,
            },
            child: IntrinsicWidth(
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
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChatName extends StatelessWidget {
  final ChatType type;
  const ChatName({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: switch (type) {
        .user => .centerRight,
        .assistant => .centerLeft,
      },
      child: Padding(
        padding: const .only(left: 4, right: 4, top: 8),
        child: DefaultTextStyle.merge(
          style: const .new(fontWeight: .bold),
          child: switch (type) {
            .user => const Text('Kamu'),
            .assistant => const Text('Asisten AI'),
          },
        ),
      ),
    );
  }
}
