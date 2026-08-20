import 'dart:async';

import 'package:ikarus/bindings.dart';
import 'package:ikarus/crux.dart';
import 'package:ikarus/crux/vpl/interpreter.dart';
import 'package:ikarus/design.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final _interpreter = Interpreter();
  final _browser = BrowserSingleton.instance();
  final _statements = <RawStatement>[];
  var _isRunning = false;

  @override
  void initState() {
    super.initState();
    _browser.registerListener(callback: _handleChange);
  }

  @override
  void dispose() {
    _interpreter.dispose();
    _browser.dispose();
    super.dispose();
  }

  Future<void> _handleStart() async {
    final scope = RawScope(field0: _statements).build();
    _interpreter.run(scope: scope);
  }

  Future<void> _handleChange() async {
    final isRunning = await _browser.isRunning();
    if (_isRunning == isRunning) return;
    if (!mounted) return;
    setState(() {
      _isRunning = isRunning;
    });
  }

  Future<void> _handleLaunchBrowser() async {
    await _browser.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      padding: const .only(left: 8, right: 8, bottom: 8),
      child: Column(
        spacing: 8,
        crossAxisAlignment: .stretch,
        children: [
          _buildToolbar(context),
          Expanded(child: _buildLayout(context)),
        ],
      ),
    );
  }

  Widget _buildLayout(BuildContext context) {
    return Row(
      spacing: 8,
      crossAxisAlignment: .stretch,
      children: [
        Expanded(child: _buildLeftLayout()),
        Expanded(child: _buildChat(context)),
      ],
    );
  }

  Widget _buildLeftLayout() {
    return Column(
      spacing: 8,
      crossAxisAlignment: .stretch,
      children: [
        Expanded(
          flex: 2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: .all(color: Colors.bro),
              borderRadius: const .all(.circular(8)),
            ),
            child: ClipRRect(
              clipBehavior: .antiAlias,
              borderRadius: const .all(.circular(8)),
              child: Vpl(_statements),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: .all(color: Colors.bro),
              borderRadius: const .all(.circular(8)),
            ),
            child: const Console(),
          ),
        ),
      ],
    );
  }

  Widget _buildChat(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: .all(color: Colors.bro),
        borderRadius: const .all(.circular(8)),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(padding: const .all(8), children: const []),
          ),
          Padding(
            // ignore: prefer_const_constructors
            padding: .all(8),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Input(controller: .new()),
                ), // TODO: yang bener kontrolernya
                const Button(child: Icon(FluentIcons.send_24_regular)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Container(
      padding: const .all(8),
      decoration: BoxDecoration(
        border: .all(color: Colors.bro),
        borderRadius: const .all(.circular(8)),
      ),
      child: Row(
        spacing: 2,
        children: [
          _ToolbarButton(
            onTap: _handleLaunchBrowser,
            child: switch (_isRunning) {
              true => const Icon(FluentIcons.position_to_front_24_regular),
              false => const Icon(FluentIcons.new_24_regular),
            },
          ),
          _ToolbarButton(
            // enabled: _isRunning,
            onTap: _handleStart,
            child: const Icon(FluentIcons.play_24_regular),
          ),
          // _ToolbarButton(
          //   // enabled: _isRunning,
          //   onTap: _handleStop,
          //   child: const Icon(FluentIcons.stop_24_regular),
          // ),
          // _ToolbarButton(
          //   enabled: _isRunning,
          //   child: const Icon(FluentIcons.pause_24_regular),
          // ),
        ],
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onTap;
  final Widget child;

  const _ToolbarButton({this.onTap, this.enabled = true, required this.child});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: ButtonBuilder(
        onTap: onTap,
        builder: (context, state, child) => Opacity(
          opacity: switch (enabled) {
            true => 1,
            false => 0.5,
          },
          child: Container(
            height: 32,
            width: 32,
            alignment: .center,
            decoration: BoxDecoration(
              borderRadius: const .all(.circular(4)),
              color: switch (state) {
                .rest => null,
                .hover => Colors.ov1,
                .tap => Colors.ov2,
              },
            ),
            child: Foreground(
              color: switch (state) {
                .hover => Colors.fg0,
                _ => Colors.fg1,
              },
              child: child!,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
