// class ProductCartModelList {
//   ProductCartModelList._();
//
//   static ProductCartModelList productCart = ProductCartModelList._();
//   List<ProductCartModel> productCartList;
// }

class ProductCartModel {
  String image;
  int id;
  ProductCartModel({this.image, this.id});

  ProductCartModel.fromJson(Map<String, dynamic> map){
    id = map['id'];
    image = map['image'];
  }

}

