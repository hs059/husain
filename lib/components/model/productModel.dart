class ProductModel {
  bool code;
  String message;
  List<Data> data;

  ProductModel({this.code, this.message, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  String currency;
  String permalink;
  String price;
  String salePrice;
  String regularPrice;
  String description;
  String sizePerUnit;
  String image;
  String stockCode;
  List<Reviews> reviews;
  bool isFavourited;
  toggle(){
    this.isFavourited = !this.isFavourited ;
  }

  Data(
      {this.id,
        this.name,
        this.currency,
        this.permalink,
        this.price,
        this.salePrice,
        this.regularPrice,
        this.description,
        this.sizePerUnit,
        this.image,
        this.isFavourited,
        this.stockCode,
        this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    id =int.parse( json['id'].toString());
    name = json['name'];
    currency = json['currency'];
    permalink = json['permalink'];
    price = json['price'];
    salePrice = json['sale_price'];
    regularPrice = json['regular_price'];
    description = json['description'];
    sizePerUnit = json['size_per_unit'];
    image = json['image'].toString();
    isFavourited = json['is_favourited'];
    stockCode = json['stock_code'];
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['currency'] = this.currency;
    data['permalink'] = this.permalink;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['regular_price'] = this.regularPrice;
    data['description'] = this.description;
    data['size_per_unit'] = this.sizePerUnit;
    data['image'] = this.image;
    data['is_favourited'] = this.isFavourited;
    data['stock_code'] = this.stockCode;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Reviews {
  int id;
  String comment;
  String averageRating;
  String reviewCount;
  User user;
  String createdAt;

  Reviews(
      {this.id,
        this.comment,
        this.averageRating,
        this.reviewCount,
        this.user,
        this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    averageRating = json['average_rating'];
    reviewCount = json['review_count'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['average_rating'] = this.averageRating;
    data['review_count'] = this.reviewCount;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}
class User {
  String id;
  String userName;
  String email;
  String userImage;

  User({this.id, this.userName, this.email, this.userImage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    email = json['email'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['user_image'] = this.userImage;
    return data;
  }
}
