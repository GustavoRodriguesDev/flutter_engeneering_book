import 'package:flutter/material.dart';
import 'package:flutter/src/semantics/semantics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'New Widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LabeleDivider(
              textColor: Colors.white,
              backgroundColor: Colors.black,
              label: 'My new Widget',
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}

class LabeleDivider extends LeafRenderObjectWidget {
  final String label;
  final double thickness;
  final Color textColor;
  final Color backgroundColor;

  const LabeleDivider({
    super.key,
    required this.label,
    required this.thickness,
    required this.textColor,
    required this.backgroundColor,
  });
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLabeledDivider(
      textcolor: textColor,
      label: label,
      thickness: thickness,
      backgroundColor: backgroundColor,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderLabeledDivider renderObject,
  ) {
    renderObject
      ..label = label
      ..thickness = thickness
      ..color = textColor
      ..backgoundColor = backgroundColor;
  }
}

class RenderLabeledDivider extends RenderBox {
  String _label;
  String get label => _label;
  set label(String label) {
    if (_label != label) _label = label;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  double _thickness;
  double get thickness => _thickness;
  set thickness(double thickness) {
    if (_thickness != thickness) _thickness = thickness;
    markNeedsLayout();
  }

  Color _textColor;
  Color get color => _textColor;
  set color(Color color) {
    if (_textColor != color) _textColor = color;
    markNeedsPaint();
  }

  Color _backgoundColor;
  Color get backgoundColor => _backgoundColor;
  set backgoundColor(Color backgoundColor) {
    if (_backgoundColor != backgoundColor) _backgoundColor = backgoundColor;
    markNeedsPaint();
  }

  late final TextPainter _textPainter;

  RenderLabeledDivider({
    required String label,
    required double thickness,
    required Color textcolor,
    required Color backgroundColor,
  })  : _label = label,
        _thickness = thickness,
        _textColor = textcolor,
        _backgoundColor = backgroundColor {
    _textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
  }

  @override
  void performLayout() {
    _textPainter.text = TextSpan(
      text: _label,
      style: TextStyle(color: _textColor),
    );

    _textPainter.layout();

    final double textHeight = _textPainter.size.height;
    size = constraints.constrain(
      Size(
        double.infinity,
        _thickness + textHeight,
      ),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Paint backgroundPaint = Paint()
      ..color = backgoundColor
      ..style = PaintingStyle.fill;

    final Rect backgroundRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width,
      size.height,
    );

    context.canvas.drawRect(backgroundRect, backgroundPaint);

    final double yCenter = offset.dy;

    final double textStart =
        offset.dx + (size.width - _textPainter.size.width) / 2;
    final textHeight = yCenter;

    _textPainter.paint(
      context.canvas,
      Offset(textStart, textHeight),
    );
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isSemanticBoundary = true
      ..label = 'Divider with text: $_label';
  }
}
