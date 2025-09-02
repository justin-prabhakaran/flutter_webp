import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webp/flutter_webp.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    () async {
      //testing
      final webp = FlutterWebp();

      final data = await rootBundle.load("assets/test.webp");

      webp.encodeImage(data.buffer.asUint8List());
      webp.encodeImage(data.buffer.asUint8List());
      webp.encodeImage(data.buffer.asUint8List());
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
