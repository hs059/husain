class ShowProfileModel {
  bool code;
  String message;
  Data data;

  ShowProfileModel({this.code, this.message, this.data});

  ShowProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data'] ) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  String displayName;
  String email;
  String userName;
  String mobileNumber;
  String userImage;

  Data(
      {this.id,
        this.displayName,
        this.email,
        this.userName,
        this.mobileNumber,
        this.userImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['display_name'];
    email = json['email'];
    userName = json['user_name'];
    mobileNumber = json['mobile_number'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    data['user_name'] = this.userName;
    data['mobile_number'] = this.mobileNumber;
    data['user_image'] = this.userImage;
    return data;
  }
}
