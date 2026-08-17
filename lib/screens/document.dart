import 'package:ikarus/bindings.dart';
import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final _statements = <RawStatement>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Padding(
        padding: .only(left: 8, right: 8, bottom: 8),
        child: Column(
          spacing: 8,
          crossAxisAlignment: .stretch,
          children: [
            _buildToolbar(context),
            Expanded(
              child: Row(
                spacing: 8,
                crossAxisAlignment: .stretch,
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: .all(color: Colors.bro),
                        borderRadius: .circular(8),
                      ),
                      child: Vpl(_statements),
                    ),
                  ),
                  Expanded(child: _buildChat(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChat(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: .all(color: Colors.bro),
        borderRadius: .circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(padding: .all(8), children: []),
          ),
          Padding(
            padding: .all(8),
            child: Row(
              spacing: 8,
              children: [
                Expanded(child: Input()),
                Button(child: Icon(FluentIcons.send_24_regular)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Container(
      padding: .all(8),
      decoration: BoxDecoration(
        border: .all(color: Colors.bro),
        borderRadius: .circular(8),
      ),
      child: Row(
        spacing: 2,
        children: [
          _ToolbarButton(
            onTap: () async {
              await BrowserFacade.renew();
              BrowserFacade.window()?.focus();
            },
            child: Icon(FluentIcons.new_24_regular),
          ),
          _ToolbarButton(child: Icon(FluentIcons.play_24_regular)),
          _ToolbarButton(child: Icon(FluentIcons.pause_24_regular)),
          _ToolbarButton(child: Icon(FluentIcons.stop_24_regular)),
        ],
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const _ToolbarButton({this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTap: onTap,
      builder: (context, state, child) => Container(
        height: 32,
        width: 32,
        alignment: .center,
        decoration: BoxDecoration(
          borderRadius: .circular(4),
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
      child: child,
    );
  }
}
