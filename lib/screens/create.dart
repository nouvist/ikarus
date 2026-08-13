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
        child: Container(
          constraints: .new(maxWidth: 800, maxHeight: 600),
          decoration: BoxDecoration(
            borderRadius: .circular(16),
            color: Colors.bg0,
            border: .all(color: Colors.bro),
            boxShadow: Shadows.s0,
          ),
          child: Text('galon'),
        ),
      ),
    );
  }
}
