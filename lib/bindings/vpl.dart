import 'dart:convert';

import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';

typedef VplIndexedCallback = void Function(int index);

class Vpl extends StatelessWidget {
  final VplIndexedCallback? onDelete;
  final VplIndexedCallback? onDuplicate;
  final ReorderCallback? onReorderItem;
  final List<RawStatement> statements;

  const Vpl({
    super.key,
    this.onDelete,
    this.onDuplicate,
    this.onReorderItem,
    this.statements = const [],
  });

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
      RawStatement_Variable it => VplBinding.variable(
        onDelete: () => onDelete?.call(index),
        onDuplicate: () => onDuplicate?.call(index),
        data: it,
      ),
      RawStatement_End it => VplBinding.sEnd(
        onDelete: () => onDelete?.call(index),
        onDuplicate: () => onDuplicate?.call(index),
      ),
      RawStatement_If it => VplBinding.sIf(
        onDelete: () => onDelete?.call(index),
        onDuplicate: () => onDuplicate?.call(index),
        data: it,
      ),
      RawStatement_For it => throw UnimplementedError(),
      RawStatement_Call it => VplBinding.call(
        onDelete: () => onDelete?.call(index),
        onDuplicate: () => onDuplicate?.call(index),
        data: it,
      ),
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
      padding: .all(8),
      itemCount: statements.length + 1,
      itemBuilder: (context, index) => _buildItem(context, index, nesteds),
    );
  }
}

class VplBindingInner extends StatelessWidget {
  final Variable data;

  const VplBindingInner(this.data, {super.key});

  VplBindingInner.ident(Ident data, {Key? key}) : this(.ident(data), key: key);

  @override
  Widget build(BuildContext context) {
    return VplInner(
      type: switch (data) {
        Variable_Ident() => .ident,
        _ => .value,
      },
      child: switch (data) {
        Variable_Null() => Text('null'),
        Variable_Ident it => Text(it.field0.field0),
        Variable_String it => Text(jsonEncode(it.field0.field0)),
        Variable_Number it => Text(it.field0.field0.toString()),
        Variable_Boolean it => Text(it.field0.field0.toString()),
        Variable_Computed it => throw UnimplementedError(),
      },
    );
  }
}

sealed class VplBinding implements Widget {
  const factory VplBinding.variable({
    VoidCallback? onDelete,
    VoidCallback? onDuplicate,
    required RawStatement_Variable data,
  }) = VplBindingVariable;
  const factory VplBinding.sIf({
    VoidCallback? onDelete,
    VoidCallback? onDuplicate,
    required RawStatement_If data,
  }) = VplBindingIf;
  const factory VplBinding.sEnd({
    VoidCallback? onDelete,
    VoidCallback? onDuplicate,
  }) = VplBindingEnd;
  const factory VplBinding.call({
    VoidCallback? onDelete,
    VoidCallback? onDuplicate,
    required RawStatement_Call data,
  }) = VplBindingCall;
}

class VplBindingVariable extends StatelessWidget implements VplBinding {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final RawStatement_Variable data;

  const VplBindingVariable({
    super.key,
    this.onDelete,
    this.onDuplicate,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return VplBlock(
      onDelete: onDelete,
      onDuplicate: onDuplicate,
      type: .assignment,
      child: Row(
        children: [
          Text('Variabel '),
          VplBindingInner.ident(data.field0.ident),
          Text(' sebagai '),
          VplBindingInner(data.field0.value),
        ],
      ),
    );
  }
}

class VplBindingIf extends StatelessWidget implements VplBinding {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final RawStatement_If data;

  const VplBindingIf({
    super.key,
    this.onDelete,
    this.onDuplicate,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return VplScopeStart(
      onDelete: onDelete,
      onDuplicate: onDuplicate,
      child: Row(children: [Text('Jika')]),
    );
  }
}

class VplBindingEnd extends StatelessWidget implements VplBinding {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;

  const VplBindingEnd({super.key, this.onDelete, this.onDuplicate});

  @override
  Widget build(BuildContext context) {
    return VplScopeEnd(onDelete: onDelete, onDuplicate: onDuplicate);
  }
}

class VplBindingCall extends StatelessWidget implements VplBinding {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final RawStatement_Call data;

  const VplBindingCall({
    super.key,
    this.onDelete,
    this.onDuplicate,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return VplBlock(
      onDelete: onDelete,
      onDuplicate: onDuplicate,
      type: .call,
      child: Row(children: [Text("Cetak")]),
    );
  }
}
