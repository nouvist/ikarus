import 'package:ikarus/design.dart';

class Dialog extends StatelessWidget {
  const Dialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const .all(.circular(16)),
          color: Colors.bg0,
          border: .all(color: Colors.bro),
          boxShadow: Shadows.s0,
        ),
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                const Padding(padding: .all(16), child: Text('Terjadi Galat')),
                Container(height: 1, color: Colors.bro),
                const Padding(padding: .all(16), child: Text('galon')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
