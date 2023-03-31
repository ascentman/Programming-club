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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Обмін валют'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.png'), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                  color: Colors.cyan,
                  child: Column(
                    children: const [
                      CurrencyItem(
                        currency: 'USD',
                        value: '100',
                      ),
                      CurrencyItem(
                        currency: 'EUR',
                        value: '80',
                      ),
                      CurrencyItem(
                        currency: 'PLN',
                        value: '400',
                      ),
                      CurrencyItem(
                        currency: 'UAH',
                        value: '1200',
                      ),
                    ],
                  )),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CurrencyItem extends StatelessWidget {
  final String currency;
  final String value;

  const CurrencyItem({
    Key? key,
    required this.currency,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 100,
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currency,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
