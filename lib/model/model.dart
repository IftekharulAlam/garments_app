class GarmentsApp {
  late List<Products> products;
  GarmentsApp({required this.products});
  GarmentsApp.fromJson(List json) {
    products = [];

    for (var v in json) {
      products.add(Products.fromJson(v));
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