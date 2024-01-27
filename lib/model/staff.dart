class Staff {
  late String staffName;

  Staff({required this.staffName});

  Staff.fromJson(Map<String, dynamic> json) {
    staffName = json['Name'];
  }
}


class StaffData {
  final String date;
  final String details;
  final int joma;
  final int khoroch;
  final int balance;

  StaffData({
    required this.date,
    required this.details,
    required this.joma,
    required this.khoroch,
    required this.balance,
  });

  factory StaffData.fromJson(Map<String, dynamic> json) => StaffData(
        date: json["date"],
        details: json["details"],
        joma: json["joma"],
        khoroch: json["khoroch"],
        balance: json["balance"],
      );
}
