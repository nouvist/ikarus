import 'package:ikarus/design.dart';

sealed class ChatData {
  String get message;
  factory ChatData.user(String message) = ChatDataUser;
  factory ChatData.tool(List<String> tools) = ChatDataTool;
  factory ChatData.assistant(String message) = ChatDataAssistant;
}

class ChatDataUser implements ChatData {
  @override
  String message;
  ChatDataUser(this.message);
}

class ChatDataTool implements ChatData {
  List<String> tools;
  ChatDataTool(this.tools);

  @override
  String get message {
    final map = <String, int>{};
    for (final tool in tools) {
      map[tool] = (map[tool] ?? 0) + 1;
    }

    return map.entries
        .map((entry) {
          return switch (entry.value == 1) {
            true => entry.key,
            false => '${entry.value}x ${entry.key}',
          };
        })
        .join(', ');
  }
}

class ChatDataAssistant implements ChatData {
  @override
  String message;
  ChatDataAssistant(this.message);
}

class Chat extends StatelessWidget {
  final List<ChatData> data;
  const Chat({super.key, this.data = const []});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const .all(8),
      itemCount: data.length,
      itemBuilder: (context, rawIndex) {
        final index = data.length - rawIndex - 1;
        final item = data[index];
        return switch (item) {
          ChatDataUser it => _buildUser(context, it, index),
          ChatDataTool it => _buildTool(context, it, index),
          ChatDataAssistant it => _buildAssistant(context, it, index),
        };
      },
    );
  }

  Widget _buildUser(BuildContext context, ChatDataUser data, int index) {
    return _Container(
      type: .right,
      background: Colors.bg2,
      child: Center(child: Text(data.message)),
    );
  }

  Widget _buildAssistant(
    BuildContext context,
    ChatDataAssistant data,
    int index,
  ) {
    return _Container(
      type: .left,
      background: Colors.bg1,
      child: Center(child: Text(data.message)),
    );
  }

  Widget _buildTool(BuildContext context, ChatDataTool data, int index) {
    return IntrinsicWidth(
      child: _Container(
        type: .left,
        background: Colors.bg0,
        child: Row(
          spacing: 10,
          mainAxisAlignment: .center,
          children: [
            const Icon(FluentIcons.toolbox_24_regular),
            Expanded(child: Text(data.message)),
          ],
        ),
      ),
    );
  }
}

enum _ContainerType { left, right }

class _Container extends StatelessWidget {
  final _ContainerType type;
  final Color background;
  final Widget child;

  const _Container({
    required this.type,
    required this.background,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: switch (type) {
        .left => const .only(right: 32, top: 8),
        .right => const .only(left: 32, top: 8),
      },
      child: Align(
        alignment: switch (type) {
          .left => .topLeft,
          .right => .topRight,
        },
        child: IntrinsicWidth(
          child: Container(
            constraints: const .new(minHeight: 42, maxWidth: 600),
            decoration: BoxDecoration(
              color: background,
              border: .all(color: Colors.bro),
              borderRadius: const .all(.circular(8)),
            ),
            padding: const .symmetric(horizontal: 12, vertical: 8),
            child: SelectableRegion(
              selectionControls: EmptyTextSelectionControls(),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
