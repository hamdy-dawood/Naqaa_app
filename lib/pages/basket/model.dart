class BasketsResp {
  String? productId;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productStatus;
  String? productImage;
  String? productTime;
  String? basketId;
  String? basketProductId;
  String? basketUserId;
  String? basketQuantity;
  String? basketOrderStatus;
  String? basketTime;

  BasketsResp({
    this.productId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productStatus,
    this.productImage,
    this.productTime,
    this.basketId,
    this.basketProductId,
    this.basketUserId,
    this.basketQuantity,
    this.basketOrderStatus,
    this.basketTime,
  });

  BasketsResp.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? "";
    productName = json['product_name'] ?? "";
    productDescription = json['product_description'] ?? "";
    productPrice = json['product_price'] ?? "";
    productStatus = json['product_status'] ?? "";
    productImage = json['product_image'] ?? "";
    productTime = json['product_time'] ?? "";
    basketId = json['basket_id'] ?? "";
    basketProductId = json['basket_productid'] ?? "";
    basketUserId = json['basket_userid'] ?? "";
    basketQuantity = json['basket_quantity'] ?? "";
    basketOrderStatus = json['basket_orderstatus'] ?? "";
    basketTime = json['basket_time'] ?? "";
  }
}
