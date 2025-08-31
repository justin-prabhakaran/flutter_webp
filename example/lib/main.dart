import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webp/flutter_webp.dart';

void main() async {
  print("hello world");
  final webp = FlutterWebp();
  webp.hello();

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

      final data = await rootBundle.load("assets/test.jpg");

      final bytes = data.buffer.asUint8List();

      final res = webp.getInfo(bytes);
      if (res.ok) {
        print(res.width);
        print(res.height);
      }
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
