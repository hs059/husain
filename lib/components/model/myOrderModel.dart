class MyOrderModel {
  bool code;
  String message;
  List<Data> data;

  MyOrderModel({this.code, this.message, this.data});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String dateCreated;
  String total;
  String status;
  List<Products> products;

  Data({this.id, this.dateCreated, this.total, this.status, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    total = json['total'];
    status = json['status'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['total'] = this.total;
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String name;
  String price;
  int quantity;
  String currency;
  int variationId;
  String image;
  String stockStatus;

  Products(
      {this.id,
        this.name,
        this.price,
        this.quantity,
        this.currency,
        this.variationId,
        this.image,
        this.stockStatus});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    currency = json['currency'];
    variationId = json['variation_id'];
    image = json['image'];
    stockStatus = json['stock_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['currency'] = this.currency;
    data['variation_id'] = this.variationId;
    data['image'] = this.image;
    data['stock_status'] = this.stockStatus;
    return data;
  }
}
