import 'package:ikarus/design.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  static PageRoute route() {
    return DialogRoute(builder: (context) => CreateScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: .all(16),
        child: ConstrainedBox(
          constraints: .new(maxWidth: 400, maxHeight: 600),
          child: DecoratedBox(
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
