import 'package:flutter/rendering.dart';
import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';

extension BuildContextExtension on BuildContext {
  @pragma('vm:prefer-inline')
  RenderBox? findRenderBox() {
    return findRenderObject()?.tryCast<RenderBox>();
  }

  @pragma('vm:prefer-inline')
  RenderSliver? findRenderSliver() {
    return findRenderObject()?.tryCast<RenderSliver>();
  }

  Size? calculateWidgetSize() {
    final render = findRenderObject();
    if (render is RenderBox) return render.size;
    if (render is RenderSliver) return render.paintBounds.size;
    return null;
  }

  Offset? calculateWidgetOffset([RenderObject? ancestor]) {
    return findRenderBox()?.localToGlobal(.zero, ancestor: ancestor);
  }
}
