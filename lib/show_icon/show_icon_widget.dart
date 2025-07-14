import 'package:flutter/widgets.dart';

import 'render_show_icon.dart';

class ShowIconWidget extends LeafRenderObjectWidget {
  final String label;
  final double height;
  final double width;
  final Color backgroundColor;

  const ShowIconWidget({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.height,
    required this.width,
  });
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShowIcon(
        label: label,
        backgroundColor: backgroundColor,
        size: Size(width, height));
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderShowIcon renderObject,
  ) {
    renderObject
      ..label = label
      ..backgoundColor = backgroundColor
      ..size = Size(width, height);
  }
}
