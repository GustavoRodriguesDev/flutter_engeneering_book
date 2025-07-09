import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class LabeleDivider extends LeafRenderObjectWidget {
  final String label;
  final double thickness;
  final Color color;

  const LabeleDivider({
    super.key,
    required this.label,
    required this.thickness,
    required this.color,
  });
  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    throw UnimplementedError();
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    // TODO: implement updateRenderObject
    super.updateRenderObject(context, renderObject);
  }
}

class RenderLabeledDivider extends RenderBox {
  String _label;
  String get label => _label;
  set label(String label) {
    if (_label != label) _label = label;
  }

  double _thickness;
  double get thickness => _thickness;
  set thickness(double thickness) {
    if (_thickness != thickness) _thickness = thickness;
  }

  Color _color;
  Color get color => _color;
  set color(Color color) {
    if (_color != color) _color = color;
  }

  late final TextPainter _textPainter;

  RenderLabeledDivider({
    required String label,
    required double thickness,
    required Color color,
  })  : _label = label,
        _thickness = thickness,
        _color = color {
    _textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
  }
}
