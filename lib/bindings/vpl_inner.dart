part of 'vpl.dart';

class VplBindingInner extends StatelessWidget {
  final VoidCallback? onTap;
  final Variable data;

  const VplBindingInner({super.key, this.onTap, required this.data});

  VplBindingInner.ident({Key? key, VoidCallback? onTap, required Ident data})
    : this(key: key, onTap: onTap, data: .ident(data));

  @override
  Widget build(BuildContext context) {
    if (data case Variable_Computed it) {
      return VplInnerWrapper(
        onTap: onTap,
        children: [
          VplBindingInner(data: it.field0.left),
          Text(switch (it.field0.operation) {
            .add => ' + ',
            .subtract => ' - ',
            .multiply => ' * ',
            .divide => ' / ',
            .reminder => ' % ',
            .boolAnd => ' && ',
            .boolOr => ' || ',
            .boolEq => ' == ',
            .boolLt => ' < ',
            .boolLe => ' <=',
            .boolGt => ' > ',
            .boolGe => ' >= ',
          }),
          VplBindingInner(data: it.field0.right),
        ],
      );
    }

    return VplInner(
      onTap: onTap,
      type: switch (data) {
        Variable_Ident() => .ident,
        _ => .value,
      },
      child: switch (data) {
        Variable_Null() => const Text('null'),
        Variable_Ident it => Text(it.field0.field0),
        Variable_String it => Text(jsonEncode(it.field0.field0)),
        Variable_Number it => Text(jsonEncode(it.field0.field0)),
        Variable_Boolean it => Text(switch (it.field0.field0) {
          true => 'Benar',
          false => 'Salah',
        }),
        Variable_Entity() => throw UnimplementedError(),
        Variable_Computed() => throw UnimplementedError(),
      },
    );
  }
}

class VplBindingInnerOperation extends StatelessWidget {
  final VoidCallback? onTap;
  final VarComputedOperation data;

  const VplBindingInnerOperation({super.key, this.onTap, required this.data});

  @override
  Widget build(BuildContext context) {
    return VplInnerOperation(
      type: switch (data) {
        .add => .add,
        .subtract => .subtract,
        .multiply => .multiply,
        .divide => .divide,
        .reminder => .reminder,
        .boolAnd => .boolAnd,
        .boolOr => .boolOr,
        .boolEq => .boolEq,
        .boolLt => .boolLt,
        .boolLe => .boolLe,
        .boolGt => .boolGt,
        .boolGe => .boolGe,
      },
      child: Text(switch (data) {
        .add => '+',
        .subtract => '-',
        .multiply => '*',
        .divide => '/',
        .reminder => '%',
        .boolAnd => '&&',
        .boolOr => '||',
        .boolEq => '==',
        .boolLt => '<',
        .boolLe => '<=',
        .boolGt => '>',
        .boolGe => '>=',
      }),
    );
  }
}
