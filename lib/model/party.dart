class PartyPersonal {
  late String ownerName;
  late String shopName;
  late int ownerPhone;

  late String shopAddress;
  late int shopPhone;
  PartyPersonal({
    required this.ownerName,
    required this.shopName,
    required this.ownerPhone,
    required this.shopAddress,
    required this.shopPhone,
  });

  PartyPersonal.fromJson(Map<String, dynamic> json) {
    ownerName = json['ownerName'];
    shopName = json['shopName'];
    ownerPhone = json['ownerPhone'];
    shopAddress = json['shopAddress'];
    shopPhone = json['shopPhone'];
  }
}

class PartyKhatiyan {
  late String date;
  late String details;
  late int joma;
  late int khoroch;
  late int balance;
  PartyKhatiyan({
    required this.date,
    required this.details,
    required this.joma,
    required this.khoroch,
    required this.balance,
  });

  PartyKhatiyan.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    details = json["details"];
    joma = json["joma"];
    khoroch = json["khoroch"];
    balance = json["balance"];
  }
}
