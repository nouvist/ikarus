import 'package:flutter/foundation.dart';
import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';
import 'package:ikarus/screens.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();
  await WindowManager.instance.waitUntilReadyToShow(
    .new(title: "Ikarus", titleBarStyle: .hidden, minimumSize: .new(720, 640)),
  );
  WindowManager.instance.show();
  WindowManager.instance.focus();

  runApp(
    Nested(
      children: [RestartProvider()],
      child: App(
        waitFor: Future.wait([
          Future.delayed(.new(seconds: 5)),
          RustLib.init(),
        ]),
      ),
    ),
  );
}

class App extends StatefulWidget {
  final Future<void>? waitFor;

  const App({super.key, this.waitFor});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _context = RefCell<BuildContext>();

  @override
  Widget build(BuildContext context) {
    return Root(
      waitFor: widget.waitFor,
      titlebar: Titlebar(
        menus: [
          // TitlebarMenu(child: Text('Baru')),
          // TitlebarMenu(child: Text('Buka')),
          // TitlebarMenu(child: Text('Simpan')),
          TitlebarMenu(
            onTap: () =>
                _context.value.navigator().push(SettingsScreen.route()),
            child: Text('Pengaturan'),
          ),
          if (kDebugMode) ...[
            TitlebarMenu(
              onTap: () => RestartProvider.of(context).restart(),
              child: Text('[DEBUG] Mulai Ulang'),
            ),
          ],
        ],
      ),
      home: Builder(
        builder: (context) {
          _context.value = context;
          return DocumentScreen();
        },
      ),
    );
  }
}
