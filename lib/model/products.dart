class Products {
  late String productModelNo;
  late String productDetails;
  late int productRate;
  Products({
    required this.productModelNo,
    required this.productDetails,
    required this.productRate,

  });

  Products.fromJson(Map<String, dynamic> json) {
    productModelNo = json['productModelNo'];
    productDetails = json['productDetails'];
    productRate = json['productRate'];
  }
  Map<String, dynamic> toMap() {
    return {
      'productModelNo': productModelNo,
      'productDetails': productDetails,
      'productRate': productRate,
    };
  }
}

class ProductProductionData {
  final String productionDate;
  final String productSize;
  final int productQuantity;

  ProductProductionData({
    required this.productionDate,
    required this.productSize,
    required this.productQuantity,
  });

  factory ProductProductionData.fromJson(Map<String, dynamic> json) =>
      ProductProductionData(
        productionDate: json["productionDate"],
        productSize: json["productSize"],
        productQuantity: json["productQuantity"],
      );
}
