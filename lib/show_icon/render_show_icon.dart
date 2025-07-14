import 'package:flutter/material.dart';

class RenderShowIcon extends RenderBox {
  String _label;
  String get label => _label;
  set label(String label) {
    if (_label != label) _label = label;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  Size _size;
  @override
  Size get size => _size;
  @override
  set size(Size size) {
    _size = size;
    markNeedsLayout();
  }

  Color _backgoundColor;
  Color get backgoundColor => _backgoundColor;
  set backgoundColor(Color backgoundColor) {
    if (_backgoundColor != backgoundColor) _backgoundColor = backgoundColor;
    markNeedsPaint();
  }

  late final TextPainter _textPainter;

  RenderShowIcon({
    required String label,
    required Color backgroundColor,
    required Size size,
  })  : _label = label,
        _size = size,
        _backgoundColor = backgroundColor {
    _textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
  }

  @override
  void performLayout() {
    _textPainter.text = TextSpan(
      text: _label,
      style: const TextStyle(
        fontSize: 26,
      ),
    );

    _textPainter.layout();

    size = constraints.constrain(
      Size(size.width, size.height),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Paint backgroundPaint = Paint()
      ..color = backgoundColor
      ..style = PaintingStyle.fill;
    final double yCenter = offset.dy;

    final Rect backgroundRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width,
      size.height,
    );
    final RRect backgroundRRect = RRect.fromRectAndCorners(
      backgroundRect,
      topRight: const Radius.circular(8),
      bottomLeft: const Radius.circular(8),
      bottomRight: const Radius.circular(8),
      topLeft: const Radius.circular(8),
    );
    context.canvas.drawRRect(backgroundRRect, backgroundPaint);

    final double textStart =
        offset.dx + (size.width - _textPainter.size.width) / 2;
    final textHeight = yCenter + (size.height - _textPainter.size.height) / 2;

    _textPainter.paint(
      context.canvas,
      Offset(textStart, textHeight),
    );
  }
}
