class DailySheetJoma {
  final String item;
  final String amount;
  final String date;
  final String details;
  final String status;
  final String type;
  DailySheetJoma({
    required this.item,
    required this.amount,
    required this.date,
    required this.details,
    required this.status,
    required this.type,
  });

  factory DailySheetJoma.fromJson(Map<String, dynamic> json) => DailySheetJoma(
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
