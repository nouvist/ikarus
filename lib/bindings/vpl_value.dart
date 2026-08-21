part of 'vpl.dart';

class VplBindingValue extends StatelessWidget {
  final VoidCallback? onTap;
  final Value data;

  const VplBindingValue({super.key, this.onTap, required this.data});

  VplBindingValue.ident({
    Key? key,
    VoidCallback? onTap,
    required Identifier data,
  }) : this(key: key, onTap: onTap, data: .ident(data));

  @override
  Widget build(BuildContext context) {
    if (data case Value_Computed it) {
      return VplValueWrapper(
        onTap: onTap,
        children: [
          VplBindingValue(data: it.field0.left),
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
          VplBindingValue(data: it.field0.right),
        ],
      );
    }

    return VplValue(
      onTap: onTap,
      type: switch (data) {
        Value_Ident() => .ident,
        _ => .value,
      },
      child: switch (data) {
        Value_Null() => const Text('null'),
        Value_Ident it => Text(it.field0.field0),
        Value_String it => Text(jsonEncode(it.field0.field0)),
        Value_Number it => Text(jsonEncode(it.field0.field0)),
        Value_Boolean it => Text(switch (it.field0.field0) {
          true => 'Benar',
          false => 'Salah',
        }),
        Value_Object() => throw UnimplementedError(),
        Value_Computed() => throw UnimplementedError(),
      },
    );
  }
}

class VplBindingInnerOperation extends StatelessWidget {
  final VoidCallback? onTap;
  final ValueComputedOperation data;

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
