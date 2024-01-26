class DailySheetJoma {
  DailySheetJoma({
    required this.item,
    required this.amount,
    required this.date,
    required this.status,
  });
  final String item;
  final String amount;
  final String date;
  final String status;

  factory DailySheetJoma.fromJson(Map<String, dynamic> json) => DailySheetJoma(
        item: json["item"],
        amount: json["amount"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, String> toJson() => {
        "item": item,
        "amount": amount,
        "date": date,
        "status": status,
      };
}
