import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:learning/json_converter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Value exchange',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Обмін валют'),
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
  final String _defaultValue = '1';
  late Future<Converter> _usd;
  late Future<Converter> _eur;
  late Future<Converter> _pln;
  late Future<Converter> _gbp;
  late Future<Converter> _aed;

  @override
  void initState() {
    _usd = convert(amount: _defaultValue, to: 'USD', from: 'UAH');
    _eur = convert(amount: _defaultValue, to: 'EUR', from: 'UAH');
    _pln = convert(amount: _defaultValue, to: 'PLN', from: 'UAH');
    _gbp = convert(amount: _defaultValue, to: 'GBP', from: 'UAH');
    _aed = convert(amount: _defaultValue, to: 'AED', from: 'UAH');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(
          Icons.monetization_on_outlined,
          size: 40,
        ),
        title: Text(widget.title),
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
              children: [
                const SizedBox(
                  height: 20,
                ),
                CurrencyItem(
                  currency: 'UAH',
                  value: _defaultValue,
                  isFirst: true,
                  onSubmit: (text) {
                    setState(() {
                      _usd = convert(amount: text, to: 'USD', from: 'UAH');
                      _eur = convert(amount: text, to: 'EUR', from: 'UAH');
                      _pln = convert(amount: text, to: 'PLN', from: 'UAH');
                      _gbp = convert(amount: text, to: 'GBP', from: 'UAH');
                      _aed = convert(amount: text, to: 'AED', from: 'UAH');
                    });
                  },
                ),
                FutureBuilder<Converter>(
                  future: _usd,
                  builder: (context, snapshot) {
                    return CurrencyItem(
                      currency: 'USD',
                      value: snapshot.data?.result.toStringAsFixed(2) ?? '0',
                    );
                  },
                ),
                FutureBuilder<Converter>(
                  future: _eur,
                  builder: (context, snapshot) {
                    return CurrencyItem(
                      currency: 'EUR',
                      value: snapshot.data?.result.toStringAsFixed(2) ?? '0',
                    );
                  },
                ),
                FutureBuilder<Converter>(
                    future: _pln,
                    builder: (context, snapshot) {
                      return CurrencyItem(
                        currency: 'PLN',
                        value: snapshot.data?.result.toStringAsFixed(2) ?? '0',
                      );
                    }),
                FutureBuilder<Converter>(
                    future: _gbp,
                    builder: (context, snapshot) {
                      return CurrencyItem(
                        currency: 'GBP',
                        value: snapshot.data?.result.toStringAsFixed(2) ?? '0',
                      );
                    }),
                FutureBuilder<Converter>(
                    future: _aed,
                    builder: (context, snapshot) {
                      return CurrencyItem(
                        currency: 'AED',
                        value: snapshot.data?.result.toStringAsFixed(2) ?? '0',
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Converter> convert({
    required String amount,
    required String to,
    required String from,
  }) async {
    final url = Uri.parse(
        'https://api.apilayer.com/exchangerates_data/convert?to=$to&from=$from&amount=$amount');
    final response = await http.get(
      url,
      headers: {
        'apikey': 'qFj7QLlSXU3YvCpvgzscgGX4g9mi7zNj',
      },
    );
    if (response.statusCode == 200) {
      return converterFromJson(response.body);
    } else {
      throw Exception('Failed to convert $amount to $to');
    }
  }
}

class CurrencyItem extends StatefulWidget {
  final String currency;
  final String value;
  final bool isFirst;
  final Function(String)? onSubmit;

  const CurrencyItem({
    Key? key,
    required this.currency,
    required this.value,
    this.isFirst = false,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<CurrencyItem> createState() => _CurrencyItemState();
}

class _CurrencyItemState extends State<CurrencyItem> {
  final _controller = TextEditingController();
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
                widget.currency,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              widget.isFirst
                  ? SizedBox(
                      width: 200,
                      height: 40,
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (text) {
                          widget.onSubmit?.call(text);
                        },
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
                          hintText: '1',
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
                      widget.value,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
