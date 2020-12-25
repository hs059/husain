class ProductM {
  bool code;
  String message;
  Data data;

  ProductM({this.code, this.message, this.data});

  ProductM.fromJson(Map<String, dynamic> json) {
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
  String name;
  String sku;
  String currency;
  String permalink;
  String price;
  String regularPrice;
  String salePrice;
  String discount;
  String description;
  String sizePerUnit;
  List<Images> images;
  bool isFavourited;
  String stockCode;
  List<Brand> brand;
  List<Reviews> reviews;
  List<Category> category;
  toggle(){
    this.isFavourited = !this.isFavourited ;
    print(this.isFavourited);
  }

  Data(
      {this.id,
        this.name,
        this.sku,
        this.currency,
        this.permalink,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.discount,
        this.description,
        this.sizePerUnit,
        this.images,
        this.isFavourited,
        this.stockCode,
        this.brand,
        this.category,
        this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    currency = json['currency'];
    permalink = json['permalink'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    description = json['description'];
    sizePerUnit = json['size_per_unit'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    isFavourited = json['is_favourited'];
    stockCode = json['stock_code'];
    if (json['brand'] != null) {
      brand = new List<Brand>();
      json['brand'].forEach((v) {
        brand.add(new Brand.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
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
    data['sku'] = this.sku;
    data['currency'] = this.currency;
    data['permalink'] = this.permalink;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['size_per_unit'] = this.sizePerUnit;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['is_favourited'] = this.isFavourited;
    data['stock_code'] = this.stockCode;
    if (this.brand != null) {
      data['brand'] = this.brand.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int imageNumber;
  String imageUrl;

  Images({this.imageNumber, this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    imageNumber = json['image_number'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_number'] = this.imageNumber;
    data['image_url'] = this.imageUrl;
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

class Brand {
  int termId;
  String name;
  String slug;
  int termGroup;
  int termTaxonomyId;
  String taxonomy;
  String description;
  int parent;
  int count;
  String filter;

  Brand(
      {this.termId,
        this.name,
        this.slug,
        this.termGroup,
        this.termTaxonomyId,
        this.taxonomy,
        this.description,
        this.parent,
        this.count,
        this.filter});

  Brand.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_id'] = this.termId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['term_group'] = this.termGroup;
    data['term_taxonomy_id'] = this.termTaxonomyId;
    data['taxonomy'] = this.taxonomy;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['count'] = this.count;
    data['filter'] = this.filter;
    return data;
  }
}
class Category {
  Brand parent;
  Null child;

  Category({this.parent, this.child});

  Category.fromJson(Map<String, dynamic> json) {
    parent = json['parent'] != null ? new Brand.fromJson(json['parent']) : null;
    child = json['child'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parent != null) {
      data['parent'] = this.parent.toJson();
    }
    data['child'] = this.child;
    return data;
  }
}