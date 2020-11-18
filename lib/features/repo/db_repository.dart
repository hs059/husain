import 'package:beauty/components/model/productsSQL.dart';

import 'db_client.dart';

class DBRepository {
  DBRepository._();

  static final DBRepository dbRepository = DBRepository._();

  insertNewProduct(ProductSql productSql) async {

    await DBClient.dbClient.insertNewProduct(productSql.toJson());
  }

  Future<List<ProductSql>> getAllProduct() async {
    List<Map<String, dynamic>> results =
        await DBClient.dbClient.getAllProduct();
    List<ProductSql> productSql =
        results.map((e) => ProductSql.fromJson(e)).toList();
    return productSql;
  }

  Future<List<Map<String, dynamic>>> getAllProductMap() async {
    List<Map<String, dynamic>> results =
        await DBClient.dbClient.getAllProduct();
    return results;
  }

  Future<int> deleteProduct(ProductSql productSql) async {
    int x = await DBClient.dbClient.deleteProduct(productSql.id);
    return x;
  }

  deleteAllProduct() async {
    await DBClient.dbClient.deleteAllProduct();
  }

  Future<int> updateProduct(ProductSql productSql) async {
    int x = await DBClient.dbClient
        .updateProduct(productSql.id, productSql.toJson());
    return x;
  }

  toggleOnCart(ProductSql productSql) async {
    productSql.toggleOnCart();
    int raw = await DBClient.dbClient
        .toggleOnCart(productSql.id, productSql.toJson());
    return raw;
  }
}
