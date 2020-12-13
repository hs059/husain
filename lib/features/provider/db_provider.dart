import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/features/repo/db_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DBProvider extends ChangeNotifier {
  List<ProductSql> allProducts = [];
  double totalPrize = 0.0;


  setAllProducts() async {
    this.allProducts = await DBRepository.dbRepository.getAllProduct();
    totalPrize = 0.0;

    for(int i =0 ;i<allProducts.length;i++ ){
      double price  = double.parse(allProducts[i].price).toDouble();
      double count  = (allProducts[i].count).toDouble();
      totalPrize = totalPrize +(count*price);
    }
    print('totalPrize = $totalPrize');

    notifyListeners();
  }

  bool getOnCart(int id ,ProductSql productSql){
    bool found = allProducts.any( (element) => element.idProduct == productSql.idProduct )??false;
    List<ProductSql> ffff = allProducts.where((element) => element.idProduct == productSql.idProduct ).toList();
    return ffff.length !=0;
  }
  insertNewProduct(ProductSql productSql) async {
    setAllProducts();
    bool found = allProducts.any( (element) => element.idProduct == productSql.idProduct )??false;
    if(!found){
      await DBRepository.dbRepository.insertNewProduct(productSql);
      toggleOnCart(productSql);
      setAllProducts();
    }else{

int count = productSql.count??1;
      updateProduct(
        ProductSql(
          idProduct: productSql.idProduct,
          price: productSql.price,
          count: count++,
          name:  productSql.name,
          image: productSql.image,
        ),
      );
    }
  }
  updateProduct(ProductSql productSql)async{
    await DBRepository.dbRepository.updateProduct( productSql) ;
    notifyListeners();

    setAllProducts();
  }
  subtractionProduct(ProductSql productSql) async {
    await DBRepository.dbRepository.subtractionProduct(productSql);
    setAllProducts();
  }

  deleteProduct(ProductSql productSql) async {
    await DBRepository.dbRepository.deleteProduct(productSql);
    setAllProducts();
  }
  deleteAllProduct() async {
    await DBRepository.dbRepository.deleteAllProduct();
    setAllProducts();
  }

  toggleOnCart(ProductSql productSql)async{
    await DBRepository.dbRepository.toggleOnCart(productSql);
    setAllProducts();
  }
  nullAllProduct(){
    allProducts= null ;
    notifyListeners();
  }

}
