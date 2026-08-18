import 'dart:convert';

import 'package:ikarus/crux.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';
import 'package:ikarus/screens.dart';

part 'vpl_blocks.dart';
part 'vpl_inner.dart';

class Vpl extends StatefulWidget {
  final List<RawStatement> statements;

  const Vpl(this.statements, {super.key});

  @override
  State<Vpl> createState() => _VplState();
}

class _VplState extends State<Vpl> {
  final _idents = <String>[];
  final _nesteds = <int>[];

  void _calculateIdents([bool shouldUpdate = false]) {
    if (shouldUpdate) return setState(() => _calculateIdents());
    _idents.clear();
    for (final st in widget.statements) {
      if (st case RawStatement_Variable it) {
        final next = it.field0.ident.field0;
        if (_idents.contains(next)) continue;
        _idents.add(it.field0.ident.field0);
      }
    }
  }

  void _calculateNesteds() {
    _nesteds.clear();
    var nested = 0;

    for (final st in widget.statements) {
      switch (st) {
        case RawStatement_If():
        case RawStatement_For():
          _nesteds.add((nested++).clampLower(0));
          break;
        case RawStatement_End():
          _nesteds.add((--nested).clampLower(0));
          break;
        default:
          _nesteds.add(nested.clampLower(0));
          break;
      }
    }
  }

  Future<void> _handleAdd() async {
    final st = await context.navigator().push(CreateScreen.route());
    if (!mounted) return;
    if (st == null) return;
    setState(() {
      widget.statements.add(switch (st) {
        RawStatementVariant_End() => .end(),
        RawStatementVariant_If() => .if_(.new(condition: .null_())),
        RawStatementVariant_For() => .for_(.new(condition: .null_())),
        RawStatementVariant_Variable() => .variable(
          .new(
            ident: .new(field0: "NamaVar"),
            value: .null_(),
          ),
        ),
        RawStatementVariant_Call() => throw UnimplementedError(),
      });
    });
  }

  void _handleDelete(int index) => setState(() {
    widget.statements.removeAt(index);
  });

  void _handleDuplicate(int index) => setState(() {
    widget.statements.insert(index + 1, widget.statements[index].copy());
  });

  void _handleReorderItem(int oldIndex, int newIndex) {
    if (newIndex == 0) newIndex = 1;
    if (--oldIndex < 0) return;
    if (--newIndex < 0) return;
    setState(() {
      final item = widget.statements.removeAt(oldIndex);
      widget.statements.insert(newIndex, item);
    });
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

    final data = widget.statements[index];
    final nested = nesteds[index];
    final child = switch (data) {
      RawStatement_End _ => VplBinding.sEnd(
        onDelete: () => _handleDelete(index),
        onDuplicate: () => _handleDuplicate(index),
      ),
      RawStatement_If it => VplBinding.sIf(
        onDelete: () => _handleDelete(index),
        onDuplicate: () => _handleDuplicate(index),
        data: it,
      ),
      RawStatement_For it => VplBinding.sFor(
        onDelete: () => _handleDelete(index),
        onDuplicate: () => _handleDuplicate(index),
        data: it,
      ),
      RawStatement_Variable it => VplBinding.variable(
        onDelete: () => _handleDelete(index),
        onDuplicate: () => _handleDuplicate(index),
        data: it,
      ),
      RawStatement_Call it => VplBinding.call(
        onDelete: () => _handleDelete(index),
        onDuplicate: () => _handleDuplicate(index),
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
    _calculateNesteds();
    _calculateIdents();

    return _VplInheritedData(
      idents: _idents,
      nesteds: _nesteds,
      statements: widget.statements,
      onCalculateIdents: _calculateIdents,
      onCalculateNesteds: _calculateNesteds,
      child: Stack(
        children: [
          Positioned.fill(
            child: ReorderableList(
              onReorderItem: _handleReorderItem,
              padding: .all(8),
              itemCount: widget.statements.length + 1,
              itemBuilder: (context, index) =>
                  _buildItem(context, index, _nesteds),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Button(
              onTap: _handleAdd,
              width: 48,
              padding: .zero,
              child: Icon(FluentIcons.add_24_filled),
            ),
          ),
        ],
      ),
    );
  }
}

class _VplInheritedData extends InheritedWidget {
  final List<String> idents;
  final List<int> nesteds;
  final List<RawStatement> statements;
  final VoidCallback _onCalculateIdents;
  final VoidCallback _onCalculateNesteds;

  const _VplInheritedData({
    required super.child,
    required this.idents,
    required this.nesteds,
    required this.statements,
    required this._onCalculateIdents,
    required this._onCalculateNesteds,
  });

  @pragma('vm:prefer-inline')
  void calculateIdents() => _onCalculateIdents();

  @pragma('vm:prefer-inline')
  void calculateNesteds() => _onCalculateNesteds();

  @pragma('vm:prefer-inline')
  static _VplInheritedData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_VplInheritedData>();
  }

  @pragma('vm:prefer-inline')
  static _VplInheritedData of(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  bool updateShouldNotify(_VplInheritedData oldWidget) {
    return idents != oldWidget.idents || statements != oldWidget.statements;
  }
}
