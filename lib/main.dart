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
    const .new(
      title: 'Ikarus',
      titleBarStyle: .hidden,
      minimumSize: .new(720, 640),
    ),
  );
  WindowManager.instance.show();
  WindowManager.instance.focus();

  runApp(
    RestartProvider(
      child: App(
        waitFor: Future.wait([
          .delayed(const .new(seconds: 5)),
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
          TitlebarMenu(
            onTap: () =>
                _context.value.navigator().push(SettingsScreen.route()),
            child: const Text('Pengaturan'),
          ),
          if (kDebugMode) ...[
            TitlebarMenu(
              onTap: () => RestartProvider.of(context).restart(),
              child: const Text('[DEBUG] Mulai Ulang'),
            ),
          ],
        ],
      ),
      home: Builder(
        builder: (context) {
          _context.value = context;
          return const DocumentScreen();
        },
      ),
    );
  }
}
