class PartyPersonal {
  late String ownerName;
  late String shopName;
  late String ownerPhone;
  late String ownerAddress;
  late String shopAddress;
  late String shopPhone;
  PartyPersonal({
    required this.ownerName,
    required this.shopName,
    required this.ownerPhone,
    required this.ownerAddress,
    required this.shopAddress,
    required this.shopPhone,
  });

  PartyPersonal.fromJson(Map<String, dynamic> json) {
    ownerName = json['ownerName'];
    shopName = json['shopName'];
    ownerPhone = json['ownerPhone'];
    ownerAddress = json['ownerAddress'];
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

