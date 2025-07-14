import 'package:flutter/material.dart';
import 'package:new_widget/color_margin/render_color_margin.dart';

class ColorMarginWidget extends SingleChildRenderObjectWidget {
  final EdgeInsets margin;
  final Color color;

  const ColorMarginWidget({
    super.key,
    required this.margin,
    required this.color,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderColorMargin(color: color, margin: margin);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderColorMargin renderObject) {
    super.updateRenderObject(context, renderObject);

    renderObject
      ..color = color
      ..margin = margin;
  }
}
