class Products {
  late String productModelNo;
  late int productRate;
  late String productDetails;

  late String imagePath;
  Products({
    required this.productModelNo,
    required this.imagePath,
    required this.productDetails,
    required this.productRate,
  });

  Products.fromJson(Map<String, dynamic> json) {
    productModelNo = json['productModelNo'];
    imagePath = json['imagePath'];
    productDetails = json['productDetails'];
    productRate = json['productRate'];
  }
  Map<String, dynamic> toMap() {
    return {
      'productModelNo': productModelNo,
      'imagePath': imagePath,
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
