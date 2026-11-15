import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galerie Images',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false, // gives the classic blue look from the TP
      ),
      home: const MyHomePage(title: 'Galerie Images'),
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
  int _deg = 0;
  final String _image = 'images/lightningmcqueen.jpg'; // keep your own file name here

  void _rotateImage() {
    setState(() {
      _deg = _deg + 45;
      if (_deg == 360) _deg = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final angle = _deg * pi / 180;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Images :'),
            const SizedBox(height: 20),
            // Fixed 300x300 box: the rotated image (max diagonal ~283)
            // stays inside it, so it never covers the text above.
            SizedBox(
              width: 300,
              height: 300,
              child: Center(
                child: Transform.rotate(
                  angle: angle,
                  child: Image.asset(_image, width: 200),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _rotateImage,
        tooltip: 'Rotate',
        child: const Text('Rotate'),
      ),
    );
  }
}