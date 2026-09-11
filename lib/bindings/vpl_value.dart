part of 'vpl.dart';

class VplBindingValue extends StatelessWidget {
  final VoidCallback? onTap;
  final Val data;

  const VplBindingValue({super.key, this.onTap, required this.data});

  VplBindingValue.identifier({
    Key? key,
    VoidCallback? onTap,
    required Identifier data,
  }) : this(key: key, onTap: onTap, data: .identifier(data));

  @override
  Widget build(BuildContext context) {
    if (data case Val_Computed it) {
      return VplValueWrapper(
        onTap: onTap,
        children: [
          VplBindingValue(data: it.field0.left),
          Text(switch (it.field0.operation) {
            .add => ' + ',
            .subtract => ' - ',
            .multiply => ' * ',
            .divide => ' / ',
            .modulo => ' % ',
            .boolAnd => ' && ',
            .boolOr => ' || ',
            .boolEqual => ' == ',
            .boolNotEqual => ' != ',
            .boolLessThan => ' < ',
            .boolLessThanOrEqual => ' <=',
            .boolGreaterThan => ' > ',
            .boolGreatherThanOrEqual => ' >= ',
          }),
          VplBindingValue(data: it.field0.right),
        ],
      );
    }

    return VplValue(
      onTap: onTap,
      type: switch (data) {
        Val_Identifier() => .ident,
        _ => .value,
      },
      child: switch (data) {
        Val_Null() => const Text('null'),
        Val_Identifier it => Text(it.field0.field0),
        Val_String it => Text(jsonEncode(it.field0.field0)),
        Val_Number it => Text(jsonEncode(it.field0.field0)),
        Val_Boolean it => Text(switch (it.field0.field0) {
          true => 'Benar',
          false => 'Salah',
        }),
        Val_Object() => throw UnimplementedError(),
        Val_Computed() => throw UnimplementedError(),
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
        .modulo => .reminder,
        .boolAnd => .boolAnd,
        .boolOr => .boolOr,
        .boolEqual => .boolEq,
        .boolNotEqual => .boolNe,
        .boolLessThan => .boolLt,
        .boolLessThanOrEqual => .boolLe,
        .boolGreaterThan => .boolGt,
        .boolGreatherThanOrEqual => .boolGe,
      },
      child: Text(switch (data) {
        .add => '+',
        .subtract => '-',
        .multiply => '*',
        .divide => '/',
        .modulo => '%',
        .boolAnd => '&&',
        .boolOr => '||',
        .boolEqual => '==',
        .boolNotEqual => '!=',
        .boolLessThan => '<',
        .boolLessThanOrEqual => '<=',
        .boolGreaterThan => '>',
        .boolGreatherThanOrEqual => '>=',
      }),
    );
  }
}
