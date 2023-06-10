class OrdersResp {
  String? count;
  String? basketOrderStatus;
  String? basketTicketID;
  String? basketTypeAddress;
  String? basketTime;
  String? basketPrice;

  OrdersResp({
    this.count,
    this.basketOrderStatus,
    this.basketTicketID,
    this.basketTypeAddress,
    this.basketTime,
    this.basketPrice,
  });

  OrdersResp.fromJson(Map<String, dynamic> json) {
    count = json['T'] ?? "";
    basketOrderStatus = json['basket_orderstatus'] ?? "";
    basketTicketID = json['basket_ticket'] ?? "";
    basketTypeAddress = json['basket_typeaddress'] ?? "";
    basketTime = json['basket_time'] ?? "";
    basketPrice = json['total'] ?? "";
  }
}
