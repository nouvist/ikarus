import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
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
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Root(
      home: Scaffold(
        child: Padding(
          padding: .only(left: 8, right: 8, bottom: 8),
          child: Row(
            spacing: 8,
            crossAxisAlignment: .stretch,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: .all(color: Colors.border),
                    borderRadius: .circular(8),
                  ),
                  child: Vpl(),
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: .all(color: Colors.border),
                    borderRadius: .circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Vpl extends StatelessWidget {
  const Vpl({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      VplBlock(
        cutout: .start,
        type: .start,
        child: Center(child: Text('Mulai')),
      ),
      VplBlock(
        type: .call,
        child: Center(child: Text('Fungsi 1')),
      ),
      VplScopeStart(child: Center(child: Text('Jika 1'))),
      VplBlock(
        type: .call,
        nested: 1,
        child: Center(child: Text('Fungsi 2')),
      ),
      VplBlock(
        type: .call,
        nested: 1,
        child: Center(child: Text('Fungsi 3')),
      ),
      VplScopeStart(
        nested: 1,
        child: Center(child: Text('Jika bersarang 1')),
      ),
      VplBlock(
        type: .call,
        nested: 2,
        child: Center(child: Text('Fungsi 4')),
      ),
      VplScopeEnd(nested: 1),
      VplScopeEnd(),
    ];

    final keyed = children
        .map((child) => KeyedSubtree(key: UniqueKey(), child: child))
        .toList();

    return ReorderableList(
      itemCount: keyed.length,
      padding: .all(8),
      onReorderItem: (oldIndex, newIndex) {},
      itemBuilder: (context, index) => keyed[index],
    );
  }
}
