part of 'vpl.dart';

class VplVariableDialog extends StatefulWidget {
  final int nested;
  final Value data;

  const VplVariableDialog({super.key, this.nested = 0, required this.data});

  static PageRoute<Value?> route({
    int nested = 0,
    required Value data,
    required VplInheritedData parent,
  }) {
    return DialogRoute(
      builder: (context) => VplInheritedData.inherit(
        parent: parent,
        child: VplVariableDialog(nested: nested, data: data),
      ),
    );
  }

  @override
  State<VplVariableDialog> createState() => _VplVariableDialogState();
}

class _VplVariableDialogState extends State<VplVariableDialog> {
  late var _data = widget.data.copy();
  final _string = TextEditingController();
  final _number = TextEditingController();

  @override
  void dispose() {
    _string.dispose();
    _number.dispose();
    super.dispose();
  }

  void _handleCancel() {
    context.navigator().pop();
  }

  void _handleSave() {
    if (_data case Value_String it) {
      it.field0.field0 = _string.text;
    } else if (_data case Value_Number it) {
      it.field0.field0 = double.parse(_number.text);
    }

    context.navigator().pop(_data);
  }

  VoidCallback _createTypeHandler(Value next) => () {
    setState(() {
      _data = next;
    });
  };

  VoidCallback _handleIdent(Value_Ident it) => () async {
    final inherited = VplInheritedData.of(context);
    inherited.calculateIdents();

    final next = await context.navigator().push(
      VplIdentifierDialog.route(
        nested: widget.nested + 1,
        current: it.field0.field0,
        existings: inherited.idents,
        parent: .of(context),
      ),
    );

    if (next == null) return;
    if (!mounted) return;
    setState(() {
      it.field0.field0 = next;
    });
  };

  VoidCallback _createComputedLeftHandler(Value_Computed data) => () async {
    final next = await context.navigator().push(
      VplVariableDialog.route(
        nested: widget.nested + 1,
        data: data.field0.left,
        parent: .of(context),
      ),
    );

    if (next == null) return;
    if (!mounted) return;
    setState(() {
      data.field0.left = next;
    });
  };

  VoidCallback _createComputedRightHandler(Value_Computed data) => () async {
    final next = await context.navigator().push(
      VplVariableDialog.route(
        nested: widget.nested + 1,
        data: data.field0.right,
        parent: .of(context),
      ),
    );

    if (next == null) return;
    if (!mounted) return;
    setState(() {
      data.field0.right = next;
    });
  };

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topLeft,
      child: Padding(
        padding: .only(
          top: 64,
          left: 16 + (widget.nested * 32),
          right: 16,
          bottom: 16,
        ),
        child: IntrinsicHeight(
          child: ConstrainedBox(
            constraints: const .new(
              maxWidth: 400,
              minHeight: 352,
              maxHeight: 600,
            ),
            child: Container(
              clipBehavior: .antiAlias,
              padding: const .all(16),
              decoration: BoxDecoration(
                borderRadius: const .all(.circular(16)),
                color: Colors.bg0,
                border: .all(color: Colors.bro),
                boxShadow: Shadows.s0,
              ),
              child: Column(
                children: [
                  _buildTitle(const Text('Jenis Data:')),
                  ..._buildSelector(),
                  if (_data is Value_String) ...[
                    _buildSeparator(),
                    _buildTitle(const Text('Nilai:')),
                    Input(onSubmit: (_) => _handleSave(), controller: _string),
                  ] else if (_data is Value_Number) ...[
                    _buildSeparator(),
                    _buildTitle(const Text('Nilai:')),
                    Input(
                      onSubmit: (_) => _handleSave(),
                      controller: _number,
                      type: .number,
                      formatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ] else if (_data case Value_Boolean it) ...[
                    _buildSeparator(),
                    _buildTitle(const Text('Nilai:')),
                    _buildBoolean(it),
                  ] else if (_data case Value_Ident it) ...[
                    _buildSeparator(),
                    _buildTitle(const Text('Nilai:')),
                    VplBindingInner(onTap: _handleIdent(it), data: it),
                  ] else if (_data case Value_Computed it) ...[
                    _buildSeparator(),
                    _buildTitle(const Text('Kiri:')),
                    VplBindingInner(
                      onTap: _createComputedLeftHandler(it),
                      data: it.field0.left,
                    ),
                    const Gap(12),
                    _buildTitle(const Text('Operasi:')),
                    ..._buildComputedOperation(it),
                    const Gap(12),
                    _buildTitle(const Text('Kanan:')),
                    VplBindingInner(
                      onTap: _createComputedRightHandler(it),
                      data: it.field0.right,
                    ),
                  ],
                  _buildSeparator(),
                  _buildControls(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(Text child) {
    return Padding(
      padding: const .only(bottom: 10),
      child: DefaultTextStyle.merge(
        style: const .new(fontWeight: .bold),
        child: child,
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const .symmetric(vertical: 16),
      child: Container(height: 1, color: Colors.bro),
    );
  }

  Widget _buildControls() {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Button(onTap: _handleCancel, child: const Text('Batal')),
        ),
        Expanded(
          child: Button(onTap: _handleSave, child: const Text('Simpan')),
        ),
      ],
    );
  }

  List<Widget> _buildSelector() {
    return [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: ToggleButton(
              onTap: _createTypeHandler(const .null_()),
              active: _data is Value_Null,
              child: const Text('Null'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: _createTypeHandler(.string(.new(field0: _string.text))),
              active: _data is Value_String,
              child: const Text('String'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: _createTypeHandler(.number(.new(field0: 0))),
              active: _data is Value_Number,
              child: const Text('Angka'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: _createTypeHandler(.boolean(.new(field0: true))),
              active: _data is Value_Boolean,
              child: const Text('Boolean'),
            ),
          ),
        ],
      ),
      const Gap(8),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: ToggleButton(
              onTap: _createTypeHandler(.ident(.new(field0: 'NamaVar'))),
              active: _data is Value_Ident,
              child: const Text('Variabel'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: _createTypeHandler(
                .computed(
                  .new(
                    operation: .add,
                    left: const .null_(),
                    right: const .null_(),
                  ),
                ),
              ),
              active: _data is Value_Computed,
              child: const Text('Komputasi'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: _createTypeHandler(const .object(.element)),
              active: _data is Value_Object,
              child: const Text('Objek'),
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildComputedOperation(Value_Computed data) {
    return [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .add;
              }),
              active: data.field0.operation == .add,
              child: const Text('+'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .subtract;
              }),
              active: data.field0.operation == .subtract,
              child: const Text('-'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .multiply;
              }),
              active: data.field0.operation == .multiply,
              child: const Text('*'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .divide;
              }),
              active: data.field0.operation == .divide,
              child: const Text('/'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .reminder;
              }),
              active: data.field0.operation == .reminder,
              child: const Text('%'),
            ),
          ),
        ],
      ),
      const Gap(8),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .boolAnd;
              }),
              active: data.field0.operation == .boolAnd,
              child: const Text('&&'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .boolOr;
              }),
              active: data.field0.operation == .boolOr,
              child: const Text('||'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .boolEq;
              }),
              active: data.field0.operation == .boolEq,
              child: const Text('=='),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .boolLt;
              }),
              active: data.field0.operation == .boolLt,
              child: const Text('<'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .boolLe;
              }),
              active: data.field0.operation == .boolLe,
              child: const Text('<='),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .boolGt;
              }),
              active: data.field0.operation == .boolGt,
              child: const Text('>'),
            ),
          ),
          Expanded(
            child: ToggleButton(
              onTap: () => setState(() {
                data.field0.operation = .boolGe;
              }),
              active: data.field0.operation == .boolGe,
              child: const Text('>='),
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildBoolean(Value_Boolean data) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: ToggleButton(
            active: data.field0.field0,
            onTap: () => setState(() {
              data.field0.field0 = true;
            }),
            child: const Text('Benar'),
          ),
        ),
        Expanded(
          child: ToggleButton(
            active: !data.field0.field0,
            onTap: () => setState(() {
              data.field0.field0 = false;
            }),
            child: const Text('Salah'),
          ),
        ),
      ],
    );
  }
}
