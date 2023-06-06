class Address {
  String? addressName;
  String? type;
  String? short;
  int? id;
  String? lat;
  String? long;

  Address({this.addressName, this.type, this.short, this.id,this.lat,this.long});

  Address.fromJson(Map<String, dynamic> json) {
    addressName = json['address'];
    type = json['type'];
    short = json['short'];
    id = json['id'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = addressName;
    data['type'] = type;
    data['short'] = short;
    data['id'] = id;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}