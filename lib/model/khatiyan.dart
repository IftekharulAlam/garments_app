class KhatiyanData {
  final String date;
  final String details;
  final int joma;
  final int khoroch;
  final int balance;

  KhatiyanData({
    required this.date,
    required this.details,
    required this.joma,
    required this.khoroch,
    required this.balance,
  });

  factory KhatiyanData.fromJson(Map<String, dynamic> json) => KhatiyanData(
        date: json["date"],
        details: json["details"],
        joma: json["joma"],
        khoroch: json["khoroch"],
        balance: json["balance"],
      );
}

class Khatiyan {
  late String khatiyanName;
  late String date;
  late String details;
  late int joma;
  late int khoroch;
  late int balance;
  late String segment;

  Khatiyan({
    required this.khatiyanName,
    required this.date,
    required this.details,
    required this.joma,
    required this.khoroch,
    required this.balance,
    required this.segment,
  });

  Khatiyan.fromJson(Map<String, dynamic> json) {
    khatiyanName = json['khatiyanName'];
    segment = json['segment'];
  }
  Map<String, dynamic> toMap() {
    return {
      'khatiyanName': khatiyanName,
      'date': date,
      'details': details,
      'joma': joma,
      'khoroch': khoroch,
      'balance': balance,
      'segment': segment,
    };
  }
}
