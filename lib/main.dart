import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  await WindowManager.instance.ensureInitialized();
  await WindowManager.instance.waitUntilReadyToShow(
    .new(title: "Ikarus", titleBarStyle: .hidden),
  );
  WindowManager.instance.show();
  WindowManager.instance.focus();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Root(
      home: Scaffold(
        child: Column(
          children: [
            IstnLogo(radius: 128),
            IkarusLogo(height: 128),
            NouvistLogo(height: 128),
          ],
        ),
      ),
    );
  }
}
