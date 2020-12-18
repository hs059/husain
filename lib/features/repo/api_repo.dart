import 'package:beauty/components/model/allAddressModel.dart';
import 'package:beauty/components/model/couponModel.dart';
import 'package:beauty/components/model/createOrderGet.dart';
import 'package:beauty/components/model/lineItems.dart';
import 'package:beauty/components/model/myOrderModel.dart';
import 'package:beauty/components/model/productM.dart';
import 'package:beauty/components/model/productModel.dart';
import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/model/categoryModel.dart';
import 'package:beauty/components/model/sectionModel.dart';
import 'package:beauty/components/model/showProfileModel.dart';
import 'package:beauty/components/model/sliderModel.dart';
import 'package:beauty/components/model/socialMediaModel.dart';
import 'package:beauty/components/model/subCategoryModel.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/ui/homePage/profile/screens/myOrder.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiRepository {
  ApiRepository._();

  static ApiRepository apiRepository = ApiRepository._();

  Future<CategoryModel> getCategory() async {
    Map map = await ApiClient.apiClient.getCategory();

    CategoryModel categoryModel = CategoryModel.fromJson(map);

    return categoryModel;
  }

  Future<SubCategoryModel> getSubCategory(int id) async {
    Map map = await ApiClient.apiClient.getSubCategory(id);
    SubCategoryModel subCategoryModel = SubCategoryModel.fromJson(map);
    return subCategoryModel;
  }

  Future<SliderModel> getSlider(int sliderNum) async {
    Map map = await ApiClient.apiClient.getSlider(sliderNum);
    SliderModel sliderModel = SliderModel.fromJson(map);
    return sliderModel;
  }

  Future<SectionModel> getSection(String title) async {
    Map<String, dynamic> map = await ApiClient.apiClient.getSection(title);
    SectionModel sectionModel = SectionModel.fromJson(map);
    return sectionModel;
  }

  Future<BrandModel> getBrand() async {
    Map<String, dynamic> map = await ApiClient.apiClient.getBrand();
    BrandModel brandModel = BrandModel.fromJson(map);
    return brandModel;
  }

  Future<ProductModel> getSubProduct(int id) async {
    String UserId = await SPHelper.spHelper.getUser();
    Map map = await ApiClient.apiClient.getSubProduct(id,UserId);
    ProductModel subProductModel = ProductModel.fromJson(map);
    return subProductModel;
  }

  Future<ProductModel> getProductByBrand(int id) async {
    String UserId = await SPHelper.spHelper.getUser();
    Map map = await ApiClient.apiClient.getProductByBrand(id,UserId);
    ProductModel productModel = ProductModel.fromJson(map);
    return productModel;
  }

  Future<ProductM> getProductDetails(int id) async {
    String UserId = await SPHelper.spHelper.getUser();
    Map map = await ApiClient.apiClient.getProductDetails(id,UserId);
    if(map['code']){
      ProductM productM = ProductM.fromJson(map);
      return productM;
    }else{
      Get.snackbar('', '',
        titleText:  Text(
          'لم يتم اضافة هذا المنتج',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          'سيتم اضافته قريبا',
          textAlign: TextAlign.center,
        ),
      );
    }

  }

  Future<ProductModel> getSearch(String search) async {
    Map map = await ApiClient.apiClient.getSearch(search);
    ProductModel productModel = ProductModel.fromJson(map);
    return productModel;
  }

  Future<ProductModel> getProductByCategory(int id) async {
    Map map = await ApiClient.apiClient.getProductByCategory(id);
    ProductModel productModel = ProductModel.fromJson(map);
    return productModel;
  }

  Future<ShowProfileModel> showProfile() async {
    Map map = await ApiClient.apiClient.showProfile();
    if (map['code']) {
      ShowProfileModel showProfileModel = ShowProfileModel.fromJson(map);
      return showProfileModel;
    } else {
      return null;
    }
  }

  //
  Future<CreateOrderGet> createOrder(
    String name,
    String address1,
    String houseNum,
    String apartment,
    List<Map> product,
  ) async {
    String token = await SPHelper.spHelper.getToken();
    String UserId = await SPHelper.spHelper.getUser();
    Map map = await ApiClient.apiClient
        .createOrder(UserId, token, name, address1, houseNum, apartment, product);
    if (map['code']) {
      CreateOrderGet createOrderGet = CreateOrderGet.fromJson(map);

      return createOrderGet;
    }
  }

  Future<MyOrderModel> getAllOrder() async {
    Map map = await ApiClient.apiClient.getAllOrder();
    if (map['code']) {
      MyOrderModel myOrderModel = MyOrderModel.fromJson(map);
      return myOrderModel;
    }
  }

  Future<AllAddressModel> getAllAddress()async {
    Map map = await ApiClient.apiClient.getAllAddress() ;
    if(map['code']){
      AllAddressModel addressModel =  AllAddressModel.fromJson(map);
      return addressModel ;
    }
  }

  Future<ProductModel> getAllFav()async{
   Map map =  await ApiClient.apiClient.getAllFav();

     ProductModel productModel =  ProductModel.fromJson(map);
     // print(productModel.toJson());
     return productModel ;

  }
  Future<ProductModel> sortByCategory(int subCategoryId , String type)async{
    Map map = await ApiClient.apiClient.sortByCategory(subCategoryId, type);
    if(map['code']){
      print(map);
      ProductModel productModel = ProductModel.fromJson(map);
    return productModel ;
    }
  }
  Future<SocialMedia> socialMediaLogin(String socialId ,String displayName,String mobileNumber ,String email,String type )async{
    Map map = await ApiClient.apiClient.socialMediaLogin(socialId, displayName, mobileNumber, email, type);
    if(map['code']){
      SocialMedia socialMediaData  = SocialMedia.fromJson(map);
      print(socialMediaData.message);
      return socialMediaData ;
    }
  }


  Future<CouponModel> getCoupon(String coupon)async{
    Map map = await ApiClient.apiClient.getCoupon(coupon);
      CouponModel couponModel = CouponModel.fromJson(map);
      return couponModel ;
  }
}
