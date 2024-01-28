class DailySheetJoma {
    final String item;
  final String amount;
  final String date;
  final String details;
  final String status;
  DailySheetJoma({
    required this.item,
    required this.amount,
    required this.date,
    required this.details,
    required this.status,
  });


  factory DailySheetJoma.fromJson(Map<String, dynamic> json) => DailySheetJoma(
        item: json["item"],
        amount: json["amount"],
        date: json["date"],
        details: json["details"],
        status: json["status"],
      );

  Map<String, String> toJson() => {
        "item": item,
        "amount": amount,
        "details": details,
        "status": status,
      };
}
