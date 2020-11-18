import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/features/repo/db_repository.dart';
import 'package:flutter/material.dart';

class DBProvider extends ChangeNotifier {
  List<ProductSql> allProducts = [];
  double totalPrize = 0.0;
  setAllProducts() async {
    this.allProducts = await DBRepository.dbRepository.getAllProduct();
    // for(int i =0 ;i<allProducts.length;i++ ){
    //   double price  = double.parse(allProducts[i].price).toDouble();
    //   double count  = (allProducts[i].count).toDouble();
    //   totalPrize = totalPrize +(count*price);
    // }
    // print('totalPrize = $totalPrize');

    notifyListeners();
  }

  insertNewProduct(ProductSql productSql) async {
    setAllProducts();
    bool pppp = allProducts.any( (element) => element.idProduct == productSql.idProduct );
    print(pppp);
    print(pppp);
    if(!pppp){
      await DBRepository.dbRepository.insertNewProduct(productSql);
      toggleOnCart(productSql);

      print(productSql.toJson());
      setAllProducts();
    }else{
      updateProduct(
        ProductSql(
          idProduct: productSql.idProduct,
          price: productSql.price,
          count: productSql.count+1,
          name:  productSql.name,
          image: productSql.image,
        ),
      );
    }

  }

  deleteProduct(ProductSql productSql) async {
    await DBRepository.dbRepository.deleteProduct(productSql);
    setAllProducts();
  }

  deleteAllProduct() async {
    await DBRepository.dbRepository.deleteAllProduct();
    setAllProducts();
  }

  updateProduct(ProductSql productSql)async{
    await DBRepository.dbRepository.updateProduct( productSql) ;
    setAllProducts();
  }

  toggleOnCart(ProductSql productSql)async{
    await DBRepository.dbRepository.toggleOnCart(productSql);
    setAllProducts();

  }

}