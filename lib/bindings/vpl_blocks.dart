part of 'vpl.dart';

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
  const factory VplBinding.sFor({
    VoidCallback? onDelete,
    VoidCallback? onDuplicate,
    required RawStatement_For data,
  }) = VplBindingFor;
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

class VplBindingVariable extends StatefulWidget implements VplBinding {
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
  State<VplBindingVariable> createState() => _VplBindingVariableState();
}

class _VplBindingVariableState extends State<VplBindingVariable> {
  Future<void> _handleIdentifier() async {
    final inherited = _VplInheritedData.of(context);
    inherited.calculateIdents();
    final next = await context.navigator().push(
      VplIdentDialog.route(
        current: widget.data.field0.ident.field0,
        existings: inherited.idents,
      ),
    );

    if (next == null) return;
    if (!mounted) return;
    setState(() {
      widget.data.field0.ident.field0 = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VplBlock(
      onDelete: widget.onDelete,
      onDuplicate: widget.onDuplicate,
      type: .assignment,
      child: Row(
        children: [
          const Text('Var '),
          VplBindingInner.ident(
            onTap: _handleIdentifier,
            data: widget.data.field0.ident,
          ),
          const Text(' sbg '),
          VplBindingInner(data: widget.data.field0.value),
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
      child: Row(
        children: [
          const Text('Jika '),
          VplBindingInner(data: data.field0.condition),
        ],
      ),
    );
  }
}

class VplBindingFor extends StatelessWidget implements VplBinding {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final RawStatement_For data;

  const VplBindingFor({
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
      child: Row(
        children: [
          const Text('Selagi '),
          VplBindingInner(data: data.field0.condition),
        ],
      ),
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

class VplBindingCall extends StatefulWidget implements VplBinding {
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
  State<VplBindingCall> createState() => _VplBindingCallState();
}

class _VplBindingCallState extends State<VplBindingCall> {
  final _map = <String, Variable>{};

  @override
  Widget build(BuildContext context) {
    final name = widget.data.field0.field0.name();
    final args = name.args();
    return VplBlock(
      onDelete: widget.onDelete,
      onDuplicate: widget.onDuplicate,
      type: .call,
      child: switch (args.isEmpty) {
        true => Center(child: Text('${name.display()}()')),
        false => Row(
          children: [
            Text('${name.display()}( '),
            for (final arg in args) ...[
              if (arg == arg[0]) const Text(', '),
              Text('$arg: '),
              const VplBindingInner(data: .null_()),
            ],
            const Text(' )'),
          ],
        ),
      },
    );
  }
}
