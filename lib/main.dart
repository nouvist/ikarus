import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/design/widgets/nouvist_logo.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Root(
      home: Column(
        children: [
          IstnLogo(radius: 128),
          IkarusLogo(height: 128),
          NouvistLogo(height: 128),
        ],
      ),
    );
  }
}
