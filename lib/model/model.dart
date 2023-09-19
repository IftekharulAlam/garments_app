class GarmentsApp {
  late List<Products> products;
  late List<PartyPersonal> partyPersonal;

  GarmentsApp({required this.products, required this.partyPersonal});
  GarmentsApp.productsFromJson(List json) {
    products = [];

    for (var v in json) {
      products.add(Products.fromJson(v));
    }
  }
  GarmentsApp.partyPersonalFromJson(List json) {
    partyPersonal = [];

    for (var v in json) {
      partyPersonal.add(PartyPersonal.fromJson(v));
    }
  }
}

class Products {
  late String productModelNo;
  late String productDetails;
  late String productRate;
  late String productSize;
  late String productAvailable;
  Products(
      {required this.productModelNo,
      required this.productDetails,
      required this.productRate,
      required this.productSize,
      required this.productAvailable});

  Products.fromJson(Map<String, dynamic> json) {
    productModelNo = json['productModelNo'];
    productDetails = json['productDetails'];
    productRate = json['productRate'];
    productSize = json['productSize'];
    productAvailable = json['productAvailable'];
  }
}

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
  late String shopName;
  late String date;
  late String billNo;
  late String Joma;
  late String Khoroch;
  late String Balance;
  PartyKhatiyan({
    required this.shopName,
    required this.date,
    required this.billNo,
    required this.Joma,
    required this.Khoroch,
    required this.Balance,
  });

  PartyKhatiyan.fromJson(Map<String, dynamic> json) {
    shopName = json['shopName'];
    date = json['date'];
    billNo = json['billNo'];
    Joma = json['Joma'];
    Khoroch = json['Khoroch'];
    Balance = json['Balance'];
  }
}
