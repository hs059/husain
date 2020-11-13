

import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/model/categoryModel.dart';
import 'package:beauty/components/model/productM.dart';
import 'package:beauty/components/model/productModel.dart';
import 'package:beauty/components/model/sectionModel.dart';
import 'package:beauty/components/model/sliderModel.dart';
import 'package:beauty/components/model/subCategoryModel.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/repo/api_repo.dart';
import 'package:beauty/value/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiProvider extends ChangeNotifier{
  ProductModel subProductModel ;
  CategoryModel category;
SubCategoryModel subCategory;
SliderModel slider1;
SliderModel slider2;
SliderModel slider3;
SectionModel latestProducts ;
SectionModel mostRated ;
SectionModel customCategory ;
ProductModel subProduct;
BrandModel brand ;
ProductModel productByBrand ;
ProductM productM ;
  getCategory()async{
    category = await ApiRepository.apiRepository.getCategory();
    notifyListeners();
  }
  Future<SubCategoryModel> getSubCategory(int id,BuildContext context)async{
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    subCategory = await ApiRepository.apiRepository.getSubCategory(id);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    notifyListeners();
    return subCategory ;
  }

   getSlider()async {
    slider1 = await ApiRepository.apiRepository.getSlider(0);
    slider2 = await ApiRepository.apiRepository.getSlider(1);
    slider3 = await ApiRepository.apiRepository.getSlider(2);
    notifyListeners();
  }
    getSection()async{
      latestProducts = await ApiRepository.apiRepository.getSection(get_latest_products);
      customCategory = await ApiRepository.apiRepository.getSection(get_product_for_custom_category);
      mostRated = await ApiRepository.apiRepository.getSection(get_product_for_custom_category);
      notifyListeners();
    }
    Future<BrandModel> getBrand()async{
      brand =await ApiRepository.apiRepository.getBrand();
      notifyListeners();
      return brand ;
    }
    Future<ProductModel> getSubProduct(int id)async{
      subProduct = await ApiRepository.apiRepository.getSubProduct(id);
      if(subProduct.code){
        return subProduct;
      }
    }
  getProductByBrand(int id)async{
    productByBrand = null ;
    productByBrand = await ApiRepository.apiRepository.getProductByBrand(id);
    notifyListeners();
  }
  getProductDetails(int id)async{
    productM = null ;
    productM = await ApiRepository.apiRepository.getProductDetails(id);
    notifyListeners();
  }
}

