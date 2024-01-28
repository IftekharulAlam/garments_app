class Products {
  late String productModelNo;
  late String productRate;
  Products({
    required this.productModelNo,
    required this.productRate,
  });

  Products.fromJson(Map<String, dynamic> json) {
    productModelNo = json['productModelNo'];
    productRate = json['productDetails'];
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

  factory ProductProductionData.fromJson(Map<String, dynamic> json) => ProductProductionData(
        productionDate: json["productionDate"],
        productSize: json["productSize"],
        productQuantity: json["productQuantity"],
    
      );
}