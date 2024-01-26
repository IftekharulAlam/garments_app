class KhatiyanData {
  final String date;
  final int joma;
  final int khoroch;
  final int balance;

  KhatiyanData({
    required this.date,
    required this.joma,
    required this.khoroch,
    required this.balance,
  });

  factory KhatiyanData.fromJson(Map<String, dynamic> json) => KhatiyanData(
        date: json["date"],
        joma: json["joma"],
        khoroch: json["khoroch"],
        balance: json["balance"],
      );
}

class Khatiyan {
  late String khatiyanName;

  Khatiyan({required this.khatiyanName});

  Khatiyan.fromJson(Map<String, dynamic> json) {
    khatiyanName = json['khatiyanName'];
  }
}
