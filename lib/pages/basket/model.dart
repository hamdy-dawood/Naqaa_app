class BasketsResp {
  // int? productId;
  // String? productName;
  // String? productNameEN;
  // String? productDescription;
  // String? productDescriptionEN;
  // int? productPrice;
  // int? productStatus;
  // String? productImage;
  // String? productTime;
  // int? basketId;
  // int? basketProductId;
  // int? basketUserId;
  // int? basketQuantity;
  // int? basketOrderStatus;
  // String? basketTime;
  int? productId;
  String? productName;
  String? productNameEN;
  String? productDescription;
  String? productDescriptionEN;
  int? productPrice;
  int? productQuantity;
  int? productStatus;
  String? productImage;
  String? productTime;
  int? basketId;
  int? basketProductId;
  int? basketUserid;
  int? basketQuantity;
  int? basketOrderStatus;
  String? basketTime;

  BasketsResp(
      this.productId,
      this.productName,
      this.productNameEN,
      this.productDescription,
      this.productDescriptionEN,
      this.productPrice,
      this.productQuantity,
      this.productStatus,
      this.productImage,
      this.productTime,
      this.basketId,
      this.basketProductId,
      this.basketUserid,
      this.basketQuantity,
      this.basketOrderStatus,
      this.basketTime);

  BasketsResp.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? 0;
    productName = json['product_name'] ?? "";
    productNameEN = json['product_nameEN'] ?? "";
    productDescription = json['product_description'] ?? "";
    productDescriptionEN = json['product_descriptionEN'] ?? "";
    productPrice = json['product_price'] ?? 0;
    productStatus = json['product_status'] ?? 0;
    productImage = json['product_image'] ?? "";
    productTime = json['product_time'] ?? "";
    basketId = json['basket_id'] ?? 0;
    basketProductId = json['basket_productid'] ?? 0;
    basketUserid = json['basket_userid'] ?? 0;
    basketQuantity = json['basket_quantity'] ?? 0;
    basketOrderStatus = json['basket_orderstatus'] ?? 0;
    basketTime = json['basket_time'] ?? "";
  }
}
