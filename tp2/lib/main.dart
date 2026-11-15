import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Gallery Images',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      initialRoute: 'first',
      routes: {
        'first': (context) => const FirstScreen(),
        'second': (context) => const SecondScreen(),
      },
    ),
  );
}

//first screen : image rotation and next button
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _deg = 0;
  final String _image = 'images/lightningmcqueen.jpg';

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
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Images :'),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, 'second');
              },
              child: const Text('Next'),
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

//second screen : go back button
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Return to the first screen.
            Navigator.pop(context);
          },
          child: const Text('Go back'),
        ),
      ),
    );
  }
}