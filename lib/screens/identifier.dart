import 'package:ikarus/design.dart';

class IdeentifierScreen extends StatelessWidget {
  const IdeentifierScreen({super.key});

  static PageRoute<String?> route() {
    return DialogRoute(builder: (context) => IdeentifierScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: .all(16),
        child: ConstrainedBox(
          constraints: .new(maxWidth: 400, maxHeight: 600),
          child: Container(
            clipBehavior: .antiAlias,
            decoration: BoxDecoration(
              borderRadius: .circular(16),
              color: Colors.bg0,
              border: .all(color: Colors.bro),
              boxShadow: Shadows.s0,
            ),
            child: Column(
              children: [Padding(padding: const .all(16), child: Input())],
            ),
          ),
        ),
      ),
    );
  }
}
