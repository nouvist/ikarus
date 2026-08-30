import 'dart:async';

import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';

class ChatBinding extends StatefulWidget {
  const ChatBinding({super.key});

  @override
  State<ChatBinding> createState() => _ChatBindingState();
}

class _ChatBindingState extends State<ChatBinding> {
  final _input = TextEditingController();
  final _chat = <ChatData>[];
  var _enabled = true;

  Future<void> _handleSubmit() async {
    final ai = await AiSingleton.instance();
    final text = _input.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _enabled = false;
      _input.clear();
      _chat.add(.user(text));
    });

    try {
      final history = _chat
          .map((it) {
            return switch (it) {
              ChatDataUser it => AiHistory.user(it.message),
              ChatDataAssistant it => AiHistory.assistant(it.message),
              ChatDataTool it => AiHistory.assistant(
                '<tool-logs>${it.message}</tool-logs>',
              ),
            };
          })
          .whereType<AiHistory>()
          .toList();

      await ai.prompt(prompt: text, history: history, cb: _handleData);
    } on AnyhowException catch (err) {
      Console.current().log(err.message);
    } finally {
      setState(() {
        _enabled = true;
      });
    }
  }

  void _handleData(AiResponse response) => setState(() {
    final last = _chat.lastOrNull;
    switch (response) {
      case AiResponse_Tool it:
        if (last case ChatDataTool last?) {
          last.tools.add(it.field0);
        } else {
          _chat.add(.tool([it.field0]));
        }
        break;
      case AiResponse_Response it:
        if (last case ChatDataAssistant last?) {
          last.message += it.field0;
        } else {
          _chat.add(.assistant(it.field0));
        }
        break;
    }
  });

  void _handleClear() => setState(() {
    _chat.clear();
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(child: Chat(data: _chat)),
              Padding(
                padding: const .only(left: 8, bottom: 8, right: 8),
                child: Row(
                  spacing: 8,
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(
                      child: Input(
                        enabled: _enabled,
                        controller: _input,
                        multiline: true,
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
          child: SizedBox(
            width: 48,
            height: 48,
            child: ClipRRect(
              clipBehavior: .antiAlias,
              borderRadius: const .all(.circular(8)),
              child: BackdropFilter(
                filter: .blur(sigmaX: 8, sigmaY: 8),
                child: Button(
                  enabled: _enabled,
                  onTap: _handleClear,
                  width: 48,
                  padding: .zero,
                  child: const Icon(FluentIcons.delete_24_regular),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
