class Products {
  late String productModelNo;
  late int productRate;
  Products({
    required this.productModelNo,
    required this.productRate,
  });

  Products.fromJson(Map<String, dynamic> json) {
    productModelNo = json['productModelNo'];
    productRate = json['productRate'];
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