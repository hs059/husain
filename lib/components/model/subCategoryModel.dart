
class SubCategoryModel {
  bool code;
  String message;
  List<Date> date;

  SubCategoryModel({this.code, this.message, this.date});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['date'] != null) {
      date = new List<Date>();
      json['date'].forEach((v) {
        date.add(new Date.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.date != null) {
      data['date'] = this.date.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Date {
  int id;
  String name;
  int count;
  String image;

  Date({this.id, this.name, this.count, this.image});

  Date.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    count = json['count'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    data['image'] = this.image;
    return data;
  }
}
