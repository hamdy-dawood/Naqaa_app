class AllProductsResp {
  String? productId;
  String? productName;
  String? productNameEN;
  String? productDescription;
  String? productDescriptionEN;
  String? productPrice;
  String? productStatus;
  String? productImage;
  String? productTime;

  AllProductsResp({
    this.productId,
    this.productName,
    this.productNameEN,
    this.productDescription,
    this.productDescriptionEN,
    this.productPrice,
    this.productStatus,
    this.productImage,
    this.productTime,
  });

  AllProductsResp.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? "";
    productName = json['product_name'] ?? "";
    productNameEN = json['product_nameEN'] ?? "";
    productDescription = json['product_description'] ?? "";
    productDescriptionEN = json['product_descriptionEN'] ?? "";
    productPrice = json['product_price'] ?? "";
    productStatus = json['product_status'] ?? "";
    productImage = json['product_image'] ?? "";
    productTime = json['product_time'] ?? "";
  }
}
