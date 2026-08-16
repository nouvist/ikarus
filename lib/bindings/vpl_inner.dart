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
            .add => " + ",
            .subtract => " - ",
            .multiply => " * ",
            .divide => " / ",
            .reminder => " % ",
            .boolAnd => " && ",
            .boolOr => " || ",
            .boolEq => " == ",
            .boolLt => " < ",
            .boolLe => " <=",
            .boolGt => " > ",
            .boolGe => " >= ",
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
        Variable_Null() => Text('null'),
        Variable_Ident it => Text(it.field0.field0),
        Variable_String it => Text(jsonEncode(it.field0.field0)),
        Variable_Number it => Text(it.field0.field0.toString()),
        Variable_Boolean it => Text(it.field0.field0.toString()),
        _ => throw UnimplementedError(),
      },
    );
  }
}
