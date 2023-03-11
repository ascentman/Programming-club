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
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'F1 Race'),
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
  bool isOnStart = true;
  final myBMW = Car(imagePath: 'assets/bmw.png', maxSpeed: 200);
  final myMercedes = Car(imagePath: 'assets/mercedes.png', maxSpeed: 300);

  void _incrementCounter() {
    setState(() {
      isOnStart = !isOnStart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarWidget(
              car: myBMW,
              isOnStart: isOnStart,
            ),
            CarWidget(
              car: myMercedes,
              isOnStart: isOnStart,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.local_fire_department),
      ),
    );
  }
}

class Car {
  final String imagePath;
  final int maxSpeed;

  Car({
    required this.imagePath,
    required this.maxSpeed,
  });
}

class CarWidget extends StatelessWidget {
  final Car car;
  final bool isOnStart;

  const CarWidget({
    Key? key,
    required this.car,
    required this.isOnStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      curve: Curves.easeInOutCirc,
      alignment: isOnStart ? Alignment.centerLeft : Alignment.centerRight,
      duration: Duration(milliseconds: ((1000 / car.maxSpeed) * 1000).toInt()),
      child: Image.asset(
        car.imagePath,
        width: 200,
      ),
    );
  }
}
