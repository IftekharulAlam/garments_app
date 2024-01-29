class DailySheetData {
  final String item;
  final String amount;
  final String date;
  final String details;
  final String status;
  final String type;
  DailySheetData({
    required this.item,
    required this.amount,
    required this.date,
    required this.details,
    required this.status,
    required this.type,
  });

  factory DailySheetData.fromJson(Map<String, dynamic> json) => DailySheetData(
        item: json["item"],
        amount: json["amount"],
        date: json["date"],
        details: json["details"],
        status: json["status"],
        type: json["type"],
      );

  Map<String, String> toJson() => {
        "item": item,
        "date": date,
        "amount": amount,
        "details": details,
        "status": status,
        "type": type,
      };
}

class DailySheetJomaKhorochData {
  final String item;
  final int amount;
  final String date;

  final String status;
  final String type;
  DailySheetJomaKhorochData({
    required this.item,
    required this.amount,
    required this.date,
    required this.status,
    required this.type,
  });

  factory DailySheetJomaKhorochData.fromJson(Map<String, dynamic> json) =>
      DailySheetJomaKhorochData(
        item: json["item"],
        amount: json["amount"],
        date: json["date"],
        status: json["status"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "date": date,
        "amount": amount,
        "status": status,
        "type": type,
      };
}
