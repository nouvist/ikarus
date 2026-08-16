export 'package:fluentui_system_icons/fluentui_system_icons.dart';
export 'package:flutter/widgets.dart';
export 'package:nested/nested.dart';
export 'package:gap/gap.dart';

export 'package:ikarus/design/constants/colors.dart';
export 'package:ikarus/design/constants/shadows.dart';
export 'package:ikarus/design/constants/typography.dart';

export 'package:ikarus/design/widgets/root.dart';
export 'package:ikarus/design/widgets/foreground.dart';
export 'package:ikarus/design/widgets/restart.dart';
export 'package:ikarus/design/widgets/inherited.dart';
export 'package:ikarus/design/widgets/titlebar.dart';
export 'package:ikarus/design/widgets/dialog.dart';
export 'package:ikarus/design/widgets/scaffold.dart';
export 'package:ikarus/design/widgets/ikarus_logo.dart';
export 'package:ikarus/design/widgets/istn_logo.dart';
export 'package:ikarus/design/widgets/nouvist_logo.dart';

// vpl
export 'package:ikarus/design/widgets/vpl_block.dart';
export 'package:ikarus/design/widgets/vpl_scope.dart';
export 'package:ikarus/design/widgets/vpl_nested.dart';
export 'package:ikarus/design/widgets/vpl_variable.dart';
export 'package:ikarus/design/widgets/vpl_controls.dart';
export 'package:ikarus/design/widgets/vpl_indicator.dart';
export 'package:ikarus/design/widgets/vpl_tile.dart';

// input
export 'package:ikarus/design/widgets/button_builder.dart';
export 'package:ikarus/design/widgets/input.dart';
export 'package:ikarus/design/widgets/button.dart';

export 'package:ikarus/design/widgets/context_menu.dart';

@pragma('vm:prefer-inline')
Future<void> yieldNow([Function()? callback]) {
  return Future.delayed(.zero, callback);
}

class RefCell<T> {
  T? _value;

  @pragma('vm:prefer-inline')
  T get value => _value!;
  @pragma('vm:prefer-inline')
  set value(T value) => _value = value;

  RefCell([this._value]);
}
