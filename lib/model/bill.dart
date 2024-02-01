

class BillProductsData {
  final String productModelNo;
  final String productSize;
  final int productRate;
  final int productQuantity;
  BillProductsData({
    required this.productModelNo,
    required this.productSize,
    required this.productRate,
    required this.productQuantity,
  });

  factory BillProductsData.fromJson(Map<String, dynamic> json) =>
      BillProductsData(
        productModelNo: json["productModelNo"],
        productSize: json["productSize"],
        productRate: json["productRate"],
        productQuantity: json["productQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "productModelNo": productModelNo,
        "productSize": productSize,
        "productRate": productRate,
        "productQuantity": productQuantity,
      };
}

class Bill {
  final String shopName;
  final String billNo;
  final String date;
  final List<BillProductsData> mybillProductsData;

  final int totalAmount;
  Bill({
    required this.shopName,
    required this.billNo,
    required this.date,
    required this.mybillProductsData,
    required this.totalAmount,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        shopName: json["shopName"],
        billNo: json["billNo"],
        date: json["date"],
        mybillProductsData: json["mybillProductsData"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "shopName": shopName,
        "billNo": billNo,
        "date": date,
        "mybillProductsData": mybillProductsData,
        "totalAmount": totalAmount,
      };
}
