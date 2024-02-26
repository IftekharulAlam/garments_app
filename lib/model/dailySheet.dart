class DailySheetData {
  final String item;
  final int amount;
  final String date;
  final String details;
  final String status;
  final String segment;

  DailySheetData({
    required this.item,
    required this.amount,
    required this.date,
    required this.details,
    required this.status,
    required this.segment,
  });

  factory DailySheetData.fromJson(Map<String, dynamic> json) => DailySheetData(
        item: json["item"],
        amount: json["amount"],
        date: json["date"],
        details: json["details"],
        status: json["status"],
        segment: json["segment"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "date": date,
        "amount": amount,
        "details": details,
        "status": status,
        "segment": segment,
      };
}

class DailySheetJomaKhorochData {
  final String item;
  final String details;
  final int amount;
  final String date;
  final String status;
  final String type;
  DailySheetJomaKhorochData({
    required this.item,
    required this.details,
    required this.amount,
    required this.date,
    required this.status,
    required this.type,
  });

  factory DailySheetJomaKhorochData.fromJson(Map<String, dynamic> json) =>
      DailySheetJomaKhorochData(
        item: json["item"],
        details: json["details"],
        amount: json["amount"],
        date: json["date"],
        status: json["status"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "details": details,
        "amount": amount,
        "date": date,
        "status": status,
        "type": type,
      };
}

class DailysheetJomaKhorochList {
  final String date;
  final String status;

  DailysheetJomaKhorochList({
    required this.status,
    required this.date,
  });

  factory DailysheetJomaKhorochList.fromJson(Map<String, dynamic> json) =>
      DailysheetJomaKhorochList(
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
      };
}
