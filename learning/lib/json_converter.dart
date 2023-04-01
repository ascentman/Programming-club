// To parse this JSON data, do
//
//     final converter = converterFromJson(jsonString);

import 'dart:convert';

Converter converterFromJson(String str) => Converter.fromJson(json.decode(str));

String converterToJson(Converter data) => json.encode(data.toJson());

class Converter {
  Converter({
    required this.date,
    required this.historical,
    required this.info,
    required this.query,
    required this.result,
    required this.success,
  });

  DateTime date;
  bool historical;
  Info info;
  Query query;
  double result;
  bool success;

  factory Converter.fromJson(Map<String, dynamic> json) => Converter(
        date: DateTime.parse(json["date"]),
        historical: json["historical"],
        info: Info.fromJson(json["info"]),
        query: Query.fromJson(json["query"]),
        result: json["result"]?.toDouble(),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "historical": historical,
        "info": info.toJson(),
        "query": query.toJson(),
        "result": result,
        "success": success,
      };
}

class Info {
  Info({
    required this.rate,
    required this.timestamp,
  });

  double rate;
  int timestamp;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        rate: json["rate"]?.toDouble(),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "timestamp": timestamp,
      };
}

class Query {
  Query({
    required this.amount,
    required this.from,
    required this.to,
  });

  int amount;
  String from;
  String to;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        amount: json["amount"],
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "from": from,
        "to": to,
      };
}
