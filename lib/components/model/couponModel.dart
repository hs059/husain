class CouponModel {
  bool status;
  String message;
  Data data;

  CouponModel({this.status, this.message, this.data});

  CouponModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String amount;
  String type;
  String individualUse;
  int usageCount;
  int usageLimit;
  String description;
  String dateExpired;

  Data(
      {this.amount,
        this.type,
        this.individualUse,
        this.usageCount,
        this.usageLimit,
        this.description,
        this.dateExpired});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    type = json['type'];
    individualUse = json['individual_use'];
    usageCount = json['usage_count'];
    usageLimit = json['usage_limit'];
    description = json['description'];
    dateExpired = json['date_expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['individual_use'] = this.individualUse;
    data['usage_count'] = this.usageCount;
    data['usage_limit'] = this.usageLimit;
    data['description'] = this.description;
    data['date_expired'] = this.dateExpired;
    return data;
  }
}