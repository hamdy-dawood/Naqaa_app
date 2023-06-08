class OrdersResp {
  String? productId;
  String? productName;
  String? productNameEN;
  String? productDescription;
  String? productDescriptionEN;
  String? productPrice;
  String? productStatus;
  String? productImage;
  String? productTime;
  String? basketId;
  String? basketProductId;
  String? basketUserId;
  String? basketQuantity;
  String? basketOrderStatus;
  String? basketLat;
  String? basketLong;
  String? basketTypeAddress;
  String? basketTime;

  OrdersResp({
    this.productId,
    this.productName,
    this.productDescription,
    this.productNameEN,
    this.productDescriptionEN,
    this.productPrice,
    this.productStatus,
    this.productImage,
    this.productTime,
    this.basketId,
    this.basketProductId,
    this.basketUserId,
    this.basketQuantity,
    this.basketOrderStatus,
    this.basketLat,
    this.basketLong,
    this.basketTypeAddress,
    this.basketTime,
  });

  OrdersResp.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? "";
    productName = json['product_name'] ?? "";
    productDescription = json['product_description'] ?? "";
    productNameEN = json['product_nameEN'] ?? "";
    productDescriptionEN = json['product_descriptionEN'] ?? "";
    productPrice = json['product_price'] ?? "";
    productStatus = json['product_status'] ?? "";
    productImage = json['product_image'] ?? "";
    productTime = json['product_time'] ?? "";
    basketId = json['basket_id'] ?? "";
    basketProductId = json['basket_productid'] ?? "";
    basketUserId = json['basket_userid'] ?? "";
    basketQuantity = json['basket_quantity'] ?? "";
    basketOrderStatus = json['basket_orderstatus'] ?? "";
    basketLat = json['basket_lat'] ?? "";
    basketLong = json['basket_long'] ?? "";
    basketTypeAddress = json['basket_typeaddress'] ?? "";
    basketTime = json['basket_time'] ?? "";
  }
}
