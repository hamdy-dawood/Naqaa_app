class OrdersResp {
  String? productId;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productStatus;
  String? productImage;
  String? productTime;
  String? orderId;
  String? orderProductId;
  String? orderBasketId;
  String? orderUserId;
  String? orderTypeAddress;
  String? orderLat;
  String? orderLong;
  String? orderQuantity;
  String? orderStatus;
  String? orderTime;

  OrdersResp({
    this.productId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productStatus,
    this.productImage,
    this.productTime,
    this.orderId,
    this.orderProductId,
    this.orderBasketId,
    this.orderUserId,
    this.orderTypeAddress,
    this.orderLat,
    this.orderLong,
    this.orderQuantity,
    this.orderStatus,
    this.orderTime,
  });

  OrdersResp.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? "";
    productName = json['product_name'] ?? "";
    productDescription = json['product_description'] ?? "";
    productPrice = json['product_price'] ?? "";
    productStatus = json['product_status'] ?? "";
    productImage = json['product_image'] ?? "";
    productTime = json['product_time'] ?? "";
    orderId = json['order_id'] ?? "";
    orderProductId = json['order_productid'] ?? "";
    orderBasketId = json['order_basketid'] ?? "";
    orderUserId = json['order_userid'] ?? "";
    orderTypeAddress = json['order_typeaddress'] ?? "";
    orderLat = json['order_lat'] ?? "";
    orderLong = json['order_long'] ?? "";
    orderQuantity = json['order_quantity'] ?? "";
    orderStatus = json['order_status'] ?? "";
    orderTime = json['order_time'] ?? "";
  }
}
