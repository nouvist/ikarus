import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';

extension StateExtension<W extends StatefulWidget> on State<W> {
  @protected
  void markNeedsBuild() {
    assert(mounted);
    context.cast<StatefulElement>().markNeedsBuild();
  }

  @protected
  void tryMarkNeedsBuild() {
    if (!mounted) return;
    markNeedsBuild();
  }
}
