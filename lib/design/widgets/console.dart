import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';

class ConsoleItem {
  final DateTime time;
  final String text;

  ConsoleItem(this.text, [DateTime? time]) : time = time ?? .now();
}

class Console extends StatefulWidget {
  const Console({super.key});

  static var _current = null as ConsoleState?;
  static ConsoleState current() => _current!;

  @override
  State<Console> createState() => _ConsoleState();
}

abstract class ConsoleState {
  void log(String str);
  void clear();
}

class _ConsoleState extends State<Console> implements ConsoleState {
  final _scroll = ScrollController();
  final _logs = <ConsoleItem>[];

  @override
  void initState() {
    super.initState();
    Console._current = this;
    registerLogger(callback: (str) => _push(.new(str)));
  }

  @override
  void dispose() {
    super.dispose();
    _scroll.dispose();
  }

  void _push(ConsoleItem item) {
    if (!mounted) return;
    setState(() {
      if (_logs.length >= 100) _logs.removeAt(0);
      _logs.add(item);
    });

    yieldNow(() {
      if (!mounted) return;
      final max = _scroll.position.maxScrollExtent;
      _scroll.position.jumpTo(max);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  void log(String str) => _push(.new(str));

  @override
  void clear() => setState(() {
    _logs.clear();
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ListView.builder(
            controller: _scroll,
            padding: const .symmetric(horizontal: 8, vertical: 4),
            itemCount: _logs.length,
            itemBuilder: _buildItem,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Button(
            onTap: clear,
            width: 48,
            padding: .zero,
            child: const Icon(FluentIcons.delete_24_regular),
          ),
        ),
      ],
    );
  }

  Widget? _buildItem(BuildContext context, int index) {
    final item = _logs[index];

    final hour = item.time.hour.toString().padLeft(2, '0');
    final minute = item.time.minute.toString().padLeft(2, '0');
    final second = item.time.second.toString().padLeft(2, '0');

    return Padding(
      padding: const .symmetric(vertical: 4),
      child: Row(
        spacing: 8,
        crossAxisAlignment: .start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.fg0,
              borderRadius: .all(.circular(6)),
            ),
            padding: const .symmetric(horizontal: 4),
            child: Foreground(
              color: Colors.bg0,
              child: Text(
                style: const .new(fontWeight: .bold),
                '$hour:$minute:$second',
              ),
            ),
          ),
          Expanded(child: Text(item.text)),
        ],
      ),
    );
  }
}
