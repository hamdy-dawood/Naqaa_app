class AllProductsResp {
  String? productId;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productStatus;
  String? productImage;
  String? productTime;

  AllProductsResp({
    this.productId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productStatus,
    this.productImage,
    this.productTime,
  });

  AllProductsResp.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? "";
    productName = json['product_name'] ?? "";
    productDescription = json['product_description'] ?? "";
    productPrice = json['product_price'] ?? "";
    productStatus = json['product_status'] ?? "";
    productImage = json['product_image'] ?? "";
    productTime = json['product_time'] ?? "";
  }
}
