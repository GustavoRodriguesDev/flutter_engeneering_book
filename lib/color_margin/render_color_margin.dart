import 'package:flutter/rendering.dart';

class RenderColorMargin extends RenderProxyBox {
  EdgeInsets _margin;

  EdgeInsets get margin => _margin;

  set margin(EdgeInsets margin) {
    _margin = margin;
    markNeedsLayout();
  }

  Color _color;

  Color get color => _color;

  set color(Color color) {
    _color = color;
    markNeedsPaint();
  }

  RenderColorMargin({
    required Color color,
    required EdgeInsets margin,
    RenderBox? child,
  })  : _margin = margin,
        _color = color;

  @override
  void performLayout() {
    final innerContraints = constraints.deflate(_margin);

    if (child != null) {
      child!.layout(innerContraints, parentUsesSize: true);
      size = Size(
        child!.size.width + margin.horizontal,
        child!.size.height + margin.vertical,
      );
    } else {
      size.contains(Offset.zero);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final rect = offset & size;
    final RRect rRect = RRect.fromRectAndCorners(
      rect,
      topRight: const Radius.circular(12),
      bottomLeft: const Radius.circular(12),
      bottomRight: const Radius.circular(12),
      topLeft: const Radius.circular(12),
    );

    context.canvas.drawRRect(rRect, paint);

    if (child != null) {
      final childOffset = offset.translate(margin.left, margin.top);
      context.paintChild(child!, childOffset);
    }
  }
}
