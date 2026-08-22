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
    final inherited = VplInheritedData.of(context);
    inherited.calculateIdents();
    final next = await context.navigator().push(
      VplIdentifierDialog.route(
        current: widget.data.field0.ident.field0,
        existings: inherited.idents,
        parent: .of(context),
      ),
    );

    if (next == null) return;
    if (!mounted) return;
    setState(() {
      widget.data.field0.ident.field0 = next;
    });
  }

  Future<void> _handleVariable() async {
    final next = await context.navigator().push(
      VplValueDialog.route(
        data: widget.data.field0.value,
        parent: .of(context),
      ),
    );

    if (next == null) return;
    if (!mounted) return;
    setState(() {
      widget.data.field0.value = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VplBlock(
      onDelete: widget.onDelete,
      onDuplicate: widget.onDuplicate,
      type: .variable,
      child: Row(
        children: [
          const Text('Var '),
          VplBindingValue.identifier(
            onTap: _handleIdentifier,
            data: widget.data.field0.ident,
          ),
          const Text(' sbg '),
          VplBindingValue(
            onTap: _handleVariable,
            data: widget.data.field0.value,
          ),
        ],
      ),
    );
  }
}

class VplBindingIf extends StatefulWidget implements VplBinding {
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
  State<VplBindingIf> createState() => _VplBindingIfState();
}

class _VplBindingIfState extends State<VplBindingIf> {
  Future<void> _handleVariable() async {
    final next = await context.navigator().push(
      VplValueDialog.route(
        data: widget.data.field0.condition,
        parent: .of(context),
      ),
    );

    if (next == null) return;
    if (!mounted) return;
    setState(() {
      widget.data.field0.condition = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VplScopeStart(
      onDelete: widget.onDelete,
      onDuplicate: widget.onDuplicate,
      child: Row(
        children: [
          const Text('Jika '),
          VplBindingValue(
            onTap: _handleVariable,
            data: widget.data.field0.condition,
          ),
        ],
      ),
    );
  }
}

class VplBindingFor extends StatefulWidget implements VplBinding {
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
  State<VplBindingFor> createState() => _VplBindingForState();
}

class _VplBindingForState extends State<VplBindingFor> {
  Future<void> _handleVariable() async {
    final next = await context.navigator().push(
      VplValueDialog.route(
        data: widget.data.field0.condition,
        parent: .of(context),
      ),
    );

    if (next == null) return;
    if (!mounted) return;
    setState(() {
      widget.data.field0.condition = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VplScopeStart(
      onDelete: widget.onDelete,
      onDuplicate: widget.onDuplicate,
      child: Row(
        children: [
          const Text('Selagi '),
          VplBindingValue(
            onTap: _handleVariable,
            data: widget.data.field0.condition,
          ),
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
  late final _args = widget.data.field0.field0.toArgs();

  VoidCallback _createVariableHandler(String arg) => () async {
    var value = null as Value?;
    if (arg.startsWith('ref ') || arg.startsWith('out ')) {
      final inherited = VplInheritedData.of(context);
      inherited.calculateIdents();

      final current = switch (_args[arg]) {
        Value_Identifier it => it.field0.field0,
        _ => '',
      };

      final next = await context.navigator().push(
        VplIdentifierDialog.route(
          current: current,
          existings: inherited.idents,
          parent: .of(context),
        ),
      );

      if (next == null) return;
      value = .identifier(.new(field0: next));
    } else {
      final next = await context.navigator().push(
        VplValueDialog.route(
          data: _args[arg] ?? const .null_(),
          parent: .of(context),
        ),
      );
      value = next;
    }

    if (value == null) return;
    if (!mounted) return;
    setState(() {
      _args[arg] = value!;
      final applied = widget.data.field0.field0.applyArgs(args: _args);
      widget.data.field0.field0 = applied;
    });
  };

  @override
  Widget build(BuildContext context) {
    final name = widget.data.field0.field0.name();
    final args = name.args();
    var i = 0;
    return VplLargeBlock(
      onDelete: widget.onDelete,
      onDuplicate: widget.onDuplicate,
      type: .call,
      child: switch (args.isEmpty) {
        true => Center(child: Text('${name.display()}()')),
        false => Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            Text(name.display()),
            for (final arg in args) ...[
              Row(
                children: [
                  const Gap(32),
                  switch (arg.contains(' ')) {
                    true => Text(
                      style: const .new(fontWeight: .bold),
                      '${arg.substring(arg.indexOf(' ') + 1)}: '
                      '${arg.substring(0, arg.indexOf(' '))} ',
                    ),
                    false => Text(
                      style: const .new(fontWeight: .bold),
                      '$arg: ',
                    ),
                  },

                  VplBindingValue(
                    onTap: _createVariableHandler(arg),
                    data: _args[arg] ?? const .null_(),
                  ),
                ],
              ),
            ],
          ],
        ),
      },
    );
  }
}
