import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        primarySwatch: Colors.indigo,
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(
          Icons.monetization_on_outlined,
          size: 40,
        ),
        title: Text(title),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: const [
                SizedBox(
                  height: 20,
                ),
                CurrencyItem(
                  currency: 'UAH',
                  value: '100',
                  isFirst: true,
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
                  currency: 'USD',
                  value: '1200',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrencyItem extends StatelessWidget {
  final String currency;
  final String value;
  final bool isFirst;

  const CurrencyItem({
    Key? key,
    required this.currency,
    required this.value,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currency,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              isFirst
                  ? SizedBox(
                      width: 200,
                      height: 40,
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Введи значення',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: const TextStyle(
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

// final converter = converterFromJson(json);
// print(converter.result);
// print(converter.success);

const json = '''
{
  "date": "2022-03-31",
  "historical": true,
  "info": {
    "rate": 0.033901,
    "timestamp": 1648771199
  },
  "query": {
    "amount": 100,
    "from": "UAH",
    "to": "USD"
  },
  "result": 5555,
  "success": true
}
''';
