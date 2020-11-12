

class SliderModel {
  bool code;
  String message;
  List<Data> data;

  SliderModel({this.code, this.message, this.data});

  SliderModel.fromJson(Map<String, dynamic> json) {
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
  String title;
  String content;
  String imageUrl;
  String prodOrCatId;
  String type;

  Data(
      {this.id,
        this.title,
        this.content,
        this.imageUrl,
        this.prodOrCatId,
        this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    imageUrl = json['image_url'];
    prodOrCatId = json['prod_or_cat_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image_url'] = this.imageUrl;
    data['prod_or_cat_id'] = this.prodOrCatId;
    data['type'] = this.type;
    return data;
  }
}
