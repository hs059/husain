import 'package:beauty/components/model/allAddressModel.dart' as addressClass;
import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/model/categoryModel.dart';
import 'package:beauty/components/model/createOrderGet.dart';
import 'package:beauty/components/model/myOrderModel.dart';
import 'package:beauty/components/model/productM.dart' as productClass;
import 'package:beauty/components/model/productModel.dart'as productModelClass;
import 'package:beauty/components/model/sectionModel.dart' as sectionClass;
import 'package:beauty/components/model/sliderModel.dart';
import 'package:beauty/components/model/subCategoryModel.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/repo/api_repo.dart';
import 'package:beauty/value/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ApiProvider extends ChangeNotifier {
  productModelClass.ProductModel subProductModel;

  CategoryModel category;
  SubCategoryModel subCategory;
  SliderModel slider1;
  SliderModel slider2;
  SliderModel slider3;
  sectionClass.SectionModel latestProducts;

  sectionClass.SectionModel mostRated;

  sectionClass.SectionModel customCategory;

  productModelClass.ProductModel subProduct;
  BrandModel brand;

  productModelClass.ProductModel productByBrand;

  productModelClass.ProductModel productSearch;

  productModelClass.ProductModel productByCategory;
  productModelClass.ProductModel productFav;

  productClass.ProductM productM;

  getCategory() async {
    category = await ApiRepository.apiRepository.getCategory();
    notifyListeners();
  }

  Future<List<SubCategoryModel>> allSubCategory() async {
    DateTime now = DateTime.now();
    print(now.toString());
    category = await ApiRepository.apiRepository.getCategory();
    List<SubCategoryModel> subCategoryList = [];
    for (int i = 0; i < category.data.length; i++) {
      SubCategoryModel subCModel =
          await ApiRepository.apiRepository.getSubCategory(category.data[i].id);
      subCategoryList.add(subCModel);
    }
    DateTime now2 = DateTime.now();
    print(now2.toString());

    print(subCategoryList.length);
    return subCategoryList;
  }

  Future<SubCategoryModel> getSubCategory(int id, BuildContext context) async {
    // Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    subCategory = await ApiRepository.apiRepository.getSubCategory(id);
    // Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    notifyListeners();
    return subCategory;
  }

  getSlider() async {
    slider1 = await ApiRepository.apiRepository.getSlider(0);
    slider2 = await ApiRepository.apiRepository.getSlider(1);
    slider3 = await ApiRepository.apiRepository.getSlider(2);
    notifyListeners();
  }

  getSection() async {
    customCategory = await ApiRepository.apiRepository
        .getSection(get_product_for_custom_category);
    mostRated = await ApiRepository.apiRepository
        .getSection(get_product_for_custom_category);
    latestProducts =
        await ApiRepository.apiRepository.getSection(get_latest_products);
    notifyListeners();
  }

  Future<BrandModel> getBrand() async {
    brand = await ApiRepository.apiRepository.getBrand();
    notifyListeners();
    return brand;
  }

  Future<productModelClass.ProductModel> getSubProduct(int id) async {
    subProduct = await ApiRepository.apiRepository.getSubProduct(id);
    if (subProduct.code) {
      return subProduct;
    }
  }

  getProductByBrand(int id) async {
    productByBrand = null;
    productByBrand = await ApiRepository.apiRepository.getProductByBrand(id);
    notifyListeners();
  }

  Future<productModelClass.ProductModel> getProductByCategory(int id) async {
    productByCategory =
        await ApiRepository.apiRepository.getProductByCategory(id);
    return productByCategory;
  }


  getProductDetails(int id) async {
    productM = null;
    productM = await ApiRepository.apiRepository.getProductDetails(id);
    print(productM.toJson());
    notifyListeners();
  }

  Future<List<productClass.Reviews>> getProductRev(int id) async {
    productM = await ApiRepository.apiRepository.getProductDetails(id);
    return productM.data.reviews;
  }

  Future<productClass.ProductM> getProductDetailsSearch(
      int id, BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    productM = await ApiRepository.apiRepository.getProductDetails(id);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    notifyListeners();
    return productM;
  }

  getProductSearch(String search) async {
    productSearch = await ApiRepository.apiRepository.getSearch(search);
    notifyListeners();
  }

  nullSearch() {
    productSearch = null;
  }

  onBoarding() async {
    Map map = await ApiClient.apiClient.onBoarding();
    if (!map['code']) {
      Get.defaultDialog(
        title: 'error',
      );
    }
    print(map);
  }

  CreateOrderGet createOrderGet;

  createOrder(
    String name,
    String address1,
    String houseNum,
    String apartment,

    List<Map> product,
  ) async {
    createOrderGet = await ApiRepository.apiRepository
        .createOrder(name, address1,houseNum, apartment, product);
    getAllOrder();
  }

  MyOrderModel myOrderModel;

  getAllOrder() async {
    myOrderModel = await ApiRepository.apiRepository.getAllOrder();
    notifyListeners();
  }

  addNewAddress(
    String type,
    String phone,
    String address,
    String houseNumber,
    String apartment,
    bool IsDefault,
    BuildContext context,
  ) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    Map map = await ApiClient.apiClient
        .addNewAddress(type, phone, address, houseNumber, apartment, IsDefault);
    getAllAddress();
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();

    if (map['code']) {
      Get.snackbar(
        'تمت اضافة العنوان',
        'بامكانك رؤية كل العنوانين ... ',
      );
      Fluttertoast.showToast(
          msg: 'تم اضافة العنوان',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          textColor: Color(0xffDAA095),
          fontSize: 16.0);

      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  addressClass.AllAddressModel allAddressModel;

  Future<addressClass.AllAddressModel> getAllAddress() async {
    allAddressModel = await ApiRepository.apiRepository.getAllAddress();
    notifyListeners();
    return allAddressModel;
  }

  removeAddress(int addressId) async {
    await ApiClient.apiClient.removeAdress(addressId);
    await getAllAddress();
  }

  addressClass.Data addressSelected;

  setAddressSelected(addressClass.Data address) {
    this.addressSelected = address;
    notifyListeners();
  }

  String comment;

  saveComment(String value) {
    this.comment = value;
    notifyListeners();
  }

  double rating;

  saveRating(double value) {
    this.rating = value;
    notifyListeners();
  }

  Future<Map> addRev(int productId) async {
    Map map = await ApiClient.apiClient.addRev(productId, rating, comment);

    if (map['code']) {
      Fluttertoast.showToast(
          msg: 'تم اضافة تعليقك',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          textColor: Color(0xffDAA095),
          fontSize: 16.0);
      return map;
    }
  }

  addFav(int productId) async {
    Map map = await ApiClient.apiClient.addFav(productId);
    print(map);
    notifyListeners();
  }

  removeFav(int productId) async {
    Map map = await ApiClient.apiClient.removeFav(productId);
    print(map);
    notifyListeners();
  }

  toggleFavUIS(sectionClass.Products product) {
    product.toggle();
    print(product.isFavourited);
    product.isFavourited ? addFav(product.id) : removeFav(product.id);
    notifyListeners();
  }
  toggleFavUI(productModelClass.Data product) {
    product.toggle();
    print(product.isFavourited);
    product.isFavourited ? addFav(product.id) : removeFav(product.id);
    notifyListeners();
  }  toggleFavUIM(productClass.Data product) {
    product.toggle();
    print(product.isFavourited);
    product.isFavourited ? addFav(int.parse( product.id )) : removeFav(int.parse( product.id ));
    notifyListeners();
  }

  ///////I use FutureBuilder for this method ////////
  Future<productModelClass.ProductModel> getAllFav()async{
 productFav =    await ApiRepository.apiRepository.getAllFav();
 print(productFav.toJson());
 return productFav ;
  }

}
