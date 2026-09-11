import 'package:flutter/foundation.dart';
import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/screens.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(List<String> args) async {
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
        initial: args.firstOrNull,
        waitFor: Future.wait([
          if (kReleaseMode) .delayed(const .new(seconds: 3)),
          RustLib.init(),
        ]),
      ),
    ),
  );
}

class App extends StatelessWidget {
  final String? initial;
  final Future<void>? waitFor;

  const App({super.key, this.initial, this.waitFor});

  @override
  Widget build(BuildContext context) {
    return Root(
      waitFor: waitFor,
      home: DocumentScreen(initial: initial),
    );
  }
}
