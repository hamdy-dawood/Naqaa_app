// class AllProductsResponse {
//   String? status;
//   List<Data>? data;
//
//   AllProductsResponse({this.status, this.data});
//
//   AllProductsResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'] ?? "";
//     // if (json['data'] != null) {
//     //   data = <Data>[];
//     //   json['data'].forEach((v) {
//     //     data!.add(Data.fromJson(v));
//     //   });
//     // }
//     data = List.from(json['data'] ?? [])
//         .map((e) => Data.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }
// }
//
// class Data {
//   String? productId;
//   String? productName;
//   String? productDescription;
//   String? productPrice;
//   String? productStatus;
//   String? productImage;
//   String? productTime;
//
//   Data({
//     this.productId,
//     this.productName,
//     this.productDescription,
//     this.productPrice,
//     this.productStatus,
//     this.productImage,
//     this.productTime,
//   });
//
//   Data.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'] ?? "";
//     productName = json['product_name'] ?? "";
//     productDescription = json['product_description'] ?? "";
//     productPrice = json['product_price'] ?? "";
//     productStatus = json['product_status'] ?? "";
//     productImage = json['product_image'] ?? "";
//     productTime = json['product_time'] ?? "";
//   }
// }

class Product {
  String? productId;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productStatus;
  String? productImage;
  String? productTime;

  Product({
    this.productId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productStatus,
    this.productImage,
    this.productTime,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? "";
    productName = json['product_name'] ?? "";
    productDescription = json['product_description'] ?? "";
    productPrice = json['product_price'] ?? "";
    productStatus = json['product_status'] ?? "";
    productImage = json['product_image'] ?? "";
    productTime = json['product_time'] ?? "";
  }
}
