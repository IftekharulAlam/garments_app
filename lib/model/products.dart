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

