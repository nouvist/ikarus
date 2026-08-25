import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:ikarus/bindings.dart';
import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';
import 'package:ikarus/screens.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  var _abort = null as AbortController?;
  final _browser = BrowserSingleton.instance();
  final _statements = <RawStatement>[];
  var _isBrowserRunning = false;
  var _isInterpreterRunning = false;
  var _pid = null as int?;

  @override
  void initState() {
    super.initState();
    _browser.registerListener(callback: _handleBrowserChange);
  }

  Future<void> _handleStart() async {
    if (_isInterpreterRunning) return;
    final scope = await RawScope(field0: _statements).build();
    final interpreter = Interpreter();
    final abort = AbortController();
    _abort = abort.clone();

    setState(() => _isInterpreterRunning = true);
    await interpreter.run(scope: scope, abort: abort);
    setState(() => _isInterpreterRunning = false);

    interpreter.dispose();
    abort.dispose();
    _abort = null;
  }

  Future<void> _handleStop() async {
    if (!_isInterpreterRunning) return;
    _abort?.abort();
  }

  Future<void> _handleBrowserChange() async {
    final isRunning = await _browser.isRunning();
    final pid = await _browser.pid();
    if (_isBrowserRunning == isRunning) return;
    if (!mounted) return;
    setState(() {
      _isBrowserRunning = isRunning;
      _pid = pid;
    });
  }

  Future<void> _handleLaunchBrowser() async {
    await _browser.initialize();
  }

  void _handleNew() {
    setState(() {
      _statements.clear();
    });
  }

  Future<void> _handleOpen() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['ikd'],
    );

    if (file == null) return;
    final buffer = await file.readAsBytes();
    final next = RawScope.fromBinary(binary: buffer);

    if (!mounted) return;
    setState(() {
      _statements.clear();
      _statements.addAll(next.field0);
    });
  }

  Future<void> _handleSave() async {
    final buffer = RawScope(field0: _statements).toBinary();
    await FilePicker.saveFile(
      type: FileType.custom,
      allowedExtensions: ['ikd'],
      fileName: 'Dokumen Ikarus.ikd',
      bytes: buffer,
    );
  }

  void _handleSettings() {
    context.navigator().push(SettingsScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      padding: const .only(left: 8, right: 8, bottom: 8),
      titlebar: Titlebar(
        menus: [
          TitlebarMenu(onTap: _handleNew, child: const Text('Baru')),
          TitlebarMenu(onTap: _handleOpen, child: const Text('Buka')),
          TitlebarMenu(onTap: _handleSave, child: const Text('Simpan')),
          TitlebarMenu(onTap: _handleSettings, child: const Text('Setelan')),
        ],
      ),
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
              child: IgnorePointer(
                ignoring: _isInterpreterRunning,
                child: Opacity(
                  opacity: switch (_isInterpreterRunning) {
                    true => 0.6,
                    false => 1,
                  },
                  child: Vpl(_statements),
                ),
              ),
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
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        border: .all(color: Colors.bro),
        borderRadius: const .all(.circular(8)),
      ),
      child: const Chat(),
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
            child: switch (_isBrowserRunning) {
              true => const Icon(FluentIcons.position_to_front_24_regular),
              false => const Icon(FluentIcons.new_24_regular),
            },
          ),
          _ToolbarButton(
            // enabled: _isRunning,
            onTap: _handleStart,
            child: const Icon(FluentIcons.play_24_regular),
          ),
          _ToolbarButton(
            // enabled: _isRunning,
            onTap: _handleStop,
            child: const Icon(FluentIcons.stop_24_regular),
          ),
          const Spacer(),
          if (_pid case final it?) Text('PID: $it'),
          const Gap(8),
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

  const _ToolbarButton({this.onTap, required this.child}) : enabled = true;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: ButtonBuilder(
        onTap: onTap,
        builder: (context, state, child) => Opacity(
          opacity: switch (enabled) {
            true => 1,
            false => 0.6,
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
