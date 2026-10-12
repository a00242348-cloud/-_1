import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CompassPage(),
    );
  }
}

class CompassPage extends StatefulWidget {
  const CompassPage({super.key});
  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  double heading = 0;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(title: const Text("البوصلة"), backgroundColor: const Color(0xFF161B22)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${heading.toStringAsFixed(0)}°", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 20),
            Transform.rotate(
              angle: heading * math.pi / 180 * -1,
              child: Container(
                width: 280, height: 280,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2), color: const Color(0xFF161B22)),
                child: const Stack(
                  children: [
                    Align(alignment: Alignment.topCenter, child: Padding(padding: EdgeInsets.only(top: 10), child: Text("N", style: TextStyle(color: Colors.red, fontSize: 24)))),
                    Align(alignment: Alignment.bottomCenter, child: Text("S")),
                    Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.only(left: 10), child: Text("W"))),
                    Align(alignment: Alignment.centerRight, child: Padding(padding: EdgeInsets.only(right: 10), child: Text("E"))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.navigation, color: Colors.red, size: 50),
            const SizedBox(height: 20),
            const Text("الأحمر يشير للشمال", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}