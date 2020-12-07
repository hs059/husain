class SocialMedia {
  bool code;
  String message;
  Data data;

  SocialMedia({this.code, this.message, this.data});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String socialId;
  String email;
  String userName;
  String displayName;
  String mobileNumber;
  String userImage;
  String token;
  bool notificationStatus;

  Data(
      {this.id,
        this.socialId,
        this.email,
        this.userName,
        this.displayName,
        this.mobileNumber,
        this.userImage,
        this.token,
        this.notificationStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socialId = json['social_id'];
    email = json['email'];
    userName = json['user_name'];
    displayName = json['display_name'];
    mobileNumber = json['mobile_number'];
    userImage = json['user_image'];
    token = json['token'];
    notificationStatus = json['notification_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['social_id'] = this.socialId;
    data['email'] = this.email;
    data['user_name'] = this.userName;
    data['display_name'] = this.displayName;
    data['mobile_number'] = this.mobileNumber;
    data['user_image'] = this.userImage;
    data['token'] = this.token;
    data['notification_status'] = this.notificationStatus;
    return data;
  }
}
