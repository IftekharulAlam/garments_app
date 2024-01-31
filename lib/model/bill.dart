class Bill {
  final String shopName;
  final String date;
  final String productModelNo;
  final String productSize;
  final String productQuantity;
  final int totalAmount;
  Bill({
    required this.shopName,
    required this.date,
    required this.productModelNo,
    required this.productSize,
    required this.productQuantity,
    required this.totalAmount,
  });

  factory Bill.fromJson(Map<String, dynamic> json) =>
      Bill(
        shopName: json["shopName"],
        date: json["date"],
        productModelNo: json["productModelNo"],
        productSize: json["productSize"],
        productQuantity: json["productQuantity"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "shopName": shopName,
        "date": date,
        "productModelNo": productModelNo,
        "productSize": productSize,
        "productQuantity": productQuantity,
        "totalAmount": totalAmount,
      };
}