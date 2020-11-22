
import 'package:beauty/features/repo/db_client.dart';

class ProductSql {
  String image;
  String name;
  String price;
  int count ;
  int id;
  int idProduct ;
  bool onCart ;

  ProductSql({
    this.image,
    this.name,
    this.price,
    this.count ,
    this.idProduct,
    this.onCart = false,
  });

  ProductSql.fromJson(Map<String, dynamic> map) {
    this.id = map[DBClient.dbClient.idColumn];
    this.name = map[DBClient.dbClient.productNameColumn];
    this.price = map[DBClient.dbClient.productPriceColumn].toString() ==null ||map[DBClient.dbClient.productPriceColumn].toString() ==''?'0':map[DBClient.dbClient.productPriceColumn].toString();
    this.count = map[DBClient.dbClient.productCountColumn] ;
    this.image=map[DBClient.dbClient.productImageColumn].toString();
    this.idProduct = map[DBClient.dbClient.productIdColumn];
    this.onCart = map[DBClient.dbClient.productOnCartColumn] ==1 ?true:false;
  }

  Map<String , dynamic> toJson() {
    return {
      DBClient.dbClient.productNameColumn: this.name,
      DBClient.dbClient.productPriceColumn: this.price,
      DBClient.dbClient.productCountColumn: this.count,
      DBClient.dbClient.productImageColumn: this.image,
      DBClient.dbClient.productIdColumn: this.idProduct,
      DBClient.dbClient.productOnCartColumn: this.onCart == true?1:0,
    };
  }
  toggleOnCart(){
    this.onCart =!this.onCart ;
  }

}
