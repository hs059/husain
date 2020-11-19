class AllAddressModel {
  bool code;
  String message;
  List<Data> data;

  AllAddressModel({this.code, this.message, this.data});

  AllAddressModel.fromJson(Map<String, dynamic> json) {
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
  String iD;
  String userId;
  String type;
  String phone;
  String fullAddress;
  String houseNumber;
  String apartment;
  String defualtAddress;

  Data(
      {this.iD,
        this.userId,
        this.type,
        this.phone,
        this.fullAddress,
        this.houseNumber,
        this.apartment,
        this.defualtAddress});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userId = json['user_id'];
    type = json['type'];
    phone = json['phone'];
    fullAddress = json['full_address'];
    houseNumber = json['house_number'];
    apartment = json['apartment'];
    defualtAddress = json['defualt_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['phone'] = this.phone;
    data['full_address'] = this.fullAddress;
    data['house_number'] = this.houseNumber;
    data['apartment'] = this.apartment;
    data['defualt_address'] = this.defualtAddress;
    return data;
  }
}
