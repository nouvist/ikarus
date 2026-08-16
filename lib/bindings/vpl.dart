import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';

class Vpl extends StatelessWidget {
  final ReorderCallback? onReorderItem;
  final List<RawStatement> statements;

  const Vpl({super.key, this.onReorderItem, this.statements = const []});

  List<int> _calculateNested() {
    final result = <int>[];
    var nested = 0;

    for (final st in statements) {
      switch (st) {
        case RawStatement_If():
        case RawStatement_For():
          result.add((nested++).clampLower(0));
          break;
        case RawStatement_End():
          result.add((--nested).clampLower(0));
          break;
        default:
          result.add(nested.clampLower(0));
          break;
      }
    }

    return result;
  }

  void _handleReorderItem(int oldIndex, int newIndex) {
    if (newIndex == 0) newIndex = 1;
    if (--oldIndex < 0) return;
    if (--newIndex < 0) return;
    onReorderItem?.call(oldIndex, newIndex);
  }

  Widget _buildItem(BuildContext context, int index, List<int> nesteds) {
    if (index-- == 0) {
      return KeyedSubtree(
        key: ValueKey(this),
        child: VplBlock(
          type: .sentinel,
          cutout: .start,
          child: Center(child: Text('Mulai')),
        ),
      );
    }

    final data = statements[index];
    final nested = nesteds[index];
    final child = switch (data) {
      RawStatement_Variable it => VplBinding.variable(it),
      RawStatement_End it => VplBinding.sEnd(),
      RawStatement_If it => VplBinding.sIf(it),
      RawStatement_For it => throw UnimplementedError(),
      RawStatement_Call it => VplBinding.call(it),
    };

    return ReorderableDragStartListener(
      key: ValueKey(data),
      index: index + 1,
      child: VplIndicator(
        type: .editing,
        child: VplNested(value: nested, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nesteds = _calculateNested();
    return ReorderableList(
      onReorderItem: _handleReorderItem,
      itemCount: statements.length + 1,
      itemBuilder: (context, index) => _buildItem(context, index, nesteds),
    );
  }
}

sealed class VplBinding implements Widget {
  const factory VplBinding.variable(RawStatement_Variable data, {Key? key}) =
      VplBindingVariable;
  const factory VplBinding.sIf(RawStatement_If data, {Key? key}) = VplBindingIf;
  const factory VplBinding.sEnd({Key? key}) = VplBindingEnd;
  const factory VplBinding.call(RawStatement_Call data, {Key? key}) =
      VplBindingCall;
}

class VplBindingVariable extends StatelessWidget implements VplBinding {
  final RawStatement_Variable? data;

  const VplBindingVariable(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return VplBlock(
      type: .assignment,
      child: Row(children: [Text('Variabel')]),
    );
  }
}

class VplBindingIf extends StatelessWidget implements VplBinding {
  final RawStatement_If? data;

  const VplBindingIf(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return VplScopeStart(child: Row(children: [Text('Jika')]));
  }
}

class VplBindingEnd extends StatelessWidget implements VplBinding {
  const VplBindingEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return VplScopeEnd();
  }
}

class VplBindingCall extends StatelessWidget implements VplBinding {
  final RawStatement_Call? data;

  const VplBindingCall(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return VplBlock(
      type: .call,
      child: Row(children: [Text("Cetak")]),
    );
  }
}
