import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DBClient {
  DBClient._();

  static final DBClient dbClient = DBClient._();

  final String productTable = 'product';
  final String idColumn = 'productId';
  final String productNameColumn = 'productNameColumn';
  final String productCountColumn = 'productCountColumn';
  final String productPriceColumn = 'productPriceColumn';
  final String productImageColumn = 'productImageColumn';
  final String productIdColumn = 'productIdColumn';
  final String productOnCartColumn = 'productOnCartColumn';

  Database database;

  initDatabase() async {
    if (database == null) {
      database = await connectToDatabase();
      return database;
    } else {
      return database;
    }
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'productsDb.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
          db.execute('''CREATE TABLE $productTable(
          $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $productNameColumn TEXT NOT NULL,
          $productCountColumn INTEGER NOT NULL,
          $productPriceColumn TEXT NOT NULL,
          $productImageColumn TEXT NOT NULL,
          $productIdColumn INTEGER NOT NULL,
          $productOnCartColumn INTEGER NOT NULL
      )''');
      },
    );
    return database;
  }

  Future<int> insertNewProduct(Map<String, dynamic> map) async {
    try {
    await initDatabase();
       int rowIndex = await database.insert(productTable, map);
      return rowIndex;
    } catch (error) {
      throw 'error is $error';
    }
  }

  Future<List<Map<String, dynamic>>> getAllProduct() async {
    try {
       await initDatabase();
      List<Map<String, dynamic>> results = await database.query(productTable);

      return results;
    } catch (error) {
      throw 'error is $error';
    }
  }
  Future<Map>getOneProduct(int productId) async{
    await initDatabase();
    List<Map<String, dynamic>> maps = await database.query(productTable,where: '$productIdColumn=?',whereArgs: [productId]);
    Map<String, dynamic> map = maps.first;
    return map;
  }

  Future<int> deleteProduct(int id) async {
    try {
  await initDatabase();
      int rows = await database
          .delete(productTable, where: '$idColumn = ?', whereArgs: [id]);
      return rows;
    } catch (error) {
      throw 'error is $error';
    }
  }
  Future<int> updateProduct(int id,Map<String,dynamic> map)async{
    try{
    await initDatabase();
    int rows =await database.update(productTable,map,where: '$productIdColumn = ?',whereArgs: [id] ) ;
    print(rows);
      return rows ;

    }catch (error){
      throw 'error is $error';
    }

  }

  // Future<int> updateProduct(int id,Map<String,dynamic> map)async{
  //   try{
  //   await initDatabase();
  //   int productId = map[productIdColumn];
  //   Map map2 = await getOneProduct(productId);
  //   map2[productCountColumn] = map2[productCountColumn]++;
  //
  //   int rows =await database.update(productTable,map2,where: '$productIdColumn = ?',whereArgs: [map['productIdColumn']] ) ;
  //
  //   print(rows);
  //     return rows ;
  //
  //   }catch (error){
  //     throw 'error is $error';
  //   }
  //
  // }

  Future<int> deleteAllProduct() async {
    try {
   await initDatabase();
      int rows = await database.delete(productTable);
      return rows;
    } catch (error) {
      throw 'error is $error';
    }
  }

  Future<int> toggleOnCart(int id,Map<String,dynamic> map)async{
    try{
      database = await initDatabase();
      int rows =await database.update(productTable,map,where: '$productOnCartColumn = ?',whereArgs: [id] ) ;
      return rows ;

    }catch (error){
      throw 'error is $error';
    }

  }
}
