import 'package:beauty/components/model/allAddressModel.dart' as addressClass;
import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/model/categoryModel.dart';
import 'package:beauty/components/model/couponModel.dart';
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
import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/string.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
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
  productModelClass.ProductModel productSort;

  productClass.ProductM productM;

  getCategory() async {
    category = await ApiRepository.apiRepository.getCategory();
    notifyListeners();
  }


bool subCat = false ;
  setSubCat(bool value){
    subCat = value ;
    notifyListeners();
  }

  Future<SubCategoryModel> getSubCategory(int id, BuildContext context) async {
    // Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    setSubCat(false);
    subCategory = await ApiRepository.apiRepository.getSubCategory(id);
    setSubCat(true);
    // Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    print(subCategory.toJson());
    notifyListeners();
    return subCategory;
  }
   getSubCategoryCons(int id, BuildContext context) async {
    // Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    subCategory = await ApiRepository.apiRepository.getSubCategory(id);
    // Provider.of<UiProvider>(context, listen: false).toggleSpinner();


  }
setSubCategoryNull(){
  subCategory = null ;
}
  getSlider() async {
    slider1 = await ApiRepository.apiRepository.getSlider(0);
    slider2 = await ApiRepository.apiRepository.getSlider(1);
    slider3 = await ApiRepository.apiRepository.getSlider(2);
    notifyListeners();
  }

  getSection() async {
    latestProducts =
    await ApiRepository.apiRepository.getSection(get_latest_products);
    customCategory = await ApiRepository.apiRepository
        .getSection(get_product_for_custom_category);
    mostRated = await ApiRepository.apiRepository
        .getSection(get_product_for_custom_category);

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
  Future<productClass.ProductM> getProductDetailsSearch(
      int id, BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    productM = await ApiRepository.apiRepository.getProductDetails(id);
    getProductByCategory(id);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    kNavigatorPush(context, ProductMScreen());
    notifyListeners();
    return productM;
  }

  bool productDetailsBool =false;
  setProductDetailsBool(bool value){
    this.productDetailsBool = value ;
    notifyListeners() ;
  }
  getProductDetails(int id,) async {
    Logger().d('getProductDetails');
    setProductDetailsBool(true);
    productM = await ApiRepository.apiRepository.getProductDetails(id);
    setProductDetailsBool(false);
    Logger().d(productM.data.category.first.parent.name);
    notifyListeners();
  }
  getProductDetailsNNNN(int id,BuildContext context) async {
    Logger().d('getProductDetails');
    setProductDetailsBool(true);
    kNavigatorPush(context, ProductMScreen());
    productM = await ApiRepository.apiRepository.getProductDetails(id);
    setProductDetailsBool(false);

    notifyListeners();
  }

  Future<productClass.ProductM> getProductDetailsSlider(int id) async {
    productClass.ProductM pro = await ApiRepository.apiRepository.getProductDetails(id);
    return pro ;
  }

  Future<List<productClass.Reviews>> getProductRev(int id) async {
    productM = await ApiRepository.apiRepository.getProductDetails(id);
    return productM.data.reviews;
  }
 Future<List<productClass.Reviews>> getProductRevCon(int id) async {
    productM = await ApiRepository.apiRepository.getProductDetails(id);
   notifyListeners();
  }


  getProductSearch(String search) async {
    productSearch = await ApiRepository.apiRepository.getSearch(search);
    notifyListeners();
  }

  nullSearch() {
    productSearch = null;
  }


bool orderBool =false ;
  setOrderBool(bool value){
    this.orderBool = value ;
    print(orderBool);
    notifyListeners() ;
  }
  CreateOrderGet createOrderGet;

  createOrder(
    String name,
    String address1,
    String houseNum,
    String apartment,

    List<Map> product,
  ) async {
    setOrderBool(true);
    createOrderGet = await ApiRepository.apiRepository
        .createOrder(name, address1,houseNum, apartment, product);
    setOrderBool(false);
    Logger().d(createOrderGet.toJson());
    getAllOrder();
  }

  MyOrderModel myOrderModel;

  getAllOrder() async {
    myOrderModel = await ApiRepository.apiRepository.getAllOrder();

    notifyListeners();
  }

  Future<MyOrderModel> updateOrder()async {
    Map map = await ApiClient.apiClient.updateOrder(createOrderGet.data.orderId);
    Logger().d(map);
    if (map['code']) {
      Get.snackbar('', '',
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            'تم تحديث الطلب لحالة مدفوع',
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            'بامكانك زيارة خانة طلباتي في صفحة البيانات الشخصية',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: kBlack
            ),
          ),
          duration: Duration(seconds: 4)
      );
    }else{
      Get.snackbar('', '',
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            'رسالة تحذير',
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            'الطلب غير معرف',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: kBlack
            ),
          ),
          duration: Duration(seconds: 4)
      );

      Fluttertoast.showToast(
          msg:'الطلب غير معرف',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
          gravity: ToastGravity.TOP
      );
    }
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
    await  getAllAddress();
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
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          textColor: Colors.white,
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
  bool addressSelectedBool =false;

  setAddressSelected(addressClass.Data address) {
    this.addressSelected = address;
    addressSelectedBool = true ;
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

  bool revBool = false ;
  setRevBool(bool value){
    this.revBool =value ;
    Logger().d(revBool);
    notifyListeners();
  }
  Future<Map> addRev(int productId) async {
    setRevBool(true);
    Map map = await ApiClient.apiClient.addRev(productId, rating, comment);
    if (map['code']) {
      Fluttertoast.showToast(
          msg:'تم اضافة تعليقك',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      getProductRevCon(productId);
      setRevBool(false);
      return map;
    }
  }
  addFav(int productId) async {
    Map map = await ApiClient.apiClient.addFav(productId);
    Logger().d(map);
    getAllFav();
    notifyListeners();
  }

  removeFav(int productId) async {
    Map map = await ApiClient.apiClient.removeFav(productId);
    Logger().d(map);
    getAllFav();
    notifyListeners();
  }


  toggleFavUIS(sectionClass.Products product) {
    Logger().d('toggleFavUIS');
    product.toggle();
    product.isFavourited ? addFav(product.id) : removeFav(product.id);
    notifyListeners();
  }
  toggleFavUI(productModelClass.Data product) {
    product.toggle();
    product.isFavourited ? addFav(product.id) : removeFav(product.id);
    notifyListeners();
  }
  toggleFavUIM(productClass.Data product) {
    product.toggle();
    product.isFavourited ? addFav(int.parse( product.id )) : removeFav(int.parse( product.id ));
    notifyListeners();
  }
  remove(index){
    productFav.data.removeAt(index) ;
    notifyListeners();
  }

  ///////I use ConsumerBuilder for this method ////////

  getAllFav()async{
 productFav = await ApiRepository.apiRepository.getAllFav();
 notifyListeners();
  }  ///////I use FutureBuilder for this method ////////

  bool loadingSort =false ;
  setLoadingSort(){
    loadingSort =true ;
    Duration duration =Duration(seconds: 3) ;
    Future.delayed(duration,(){
      this.loadingSort = false ;
      notifyListeners();
    });
    notifyListeners();

    print(loadingSort);
  }

  Future<productModelClass.ProductModel> sortByCategory(int subCategoryId , String type,)async{
    // setSubCat(true);
    if(isSort){
      productSort = await ApiRepository.apiRepository.sortByCategory(subCategoryId, type) ;

    }else{
      productSort = productSort ;
    }

    // setSubCat(false);
    return productSort ;
  }
 nullProductSort(){
   productSort= null ;
   notifyListeners();
 }
  bool isSort =false ;
  setIsSort(bool value){
    this.isSort = value ;
    notifyListeners();
  }
  int typeSelected = 0 ;
  setTypeSelected(int value){
    this.typeSelected =isSort? value:this.typeSelected ;
    Logger().d('typeSelected $typeSelected');
    notifyListeners();
  }
  String  character = sort[0] ;
  setCharacter(String value){
    this.character = value ;
    Logger().d('character $character');
    notifyListeners();
  }
  initialSort(){
    setCharacter(sort[0]);
    this.typeSelected =0 ;
    setTypeSelected(0);
    notifyListeners();
  }
  Map onbourding ;
  getOnbourding()async{
    DateTime now = DateTime.now();
print('now:$now');
    onbourding = await ApiClient.apiClient.onBoarding();
    print(onbourding);
    DateTime now2 = DateTime.now();
    print('now2:$now2');
  }
Map privacyPolicy ;
  getPrivacyPolicy()async{
    Map map  = await ApiClient.apiClient.getPrivacyPolicy();
    if(map['code']){
      privacyPolicy = map ;
      print(privacyPolicy);
    }
  }

  String coupon ;
  setCoupon(String value)async{
    print(coupon);
    this.coupon = value ;
    notifyListeners();
  }

  bool loadCoupon =false;
  toggleLoadCoupon(){
    this.loadCoupon =!this.loadCoupon;
    notifyListeners();
  }

  CouponModel couponModel ;
  getCoupon()async{
    print(coupon);
    toggleLoadCoupon();
    couponModel = await ApiRepository.apiRepository.getCoupon(coupon);
    toggleLoadCoupon();
    if(couponModel.status){
      setCheckCoupon(true);
      setInitialPrizeCoupon(true);
    }else{
      Fluttertoast.showToast(
          msg: "كود كوبون غير صالح",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          textColor: Colors.white,
          gravity:ToastGravity.CENTER ,
          fontSize: 16.0);

    }
    notifyListeners();
  }

  bool checkCoupon = false ;
  setCheckCoupon(bool value){
    this.checkCoupon = value ;
    notifyListeners();
  }
  double totalPrizeOrder = 0.0;

  changeTotalPrizeOrder(double value){
    this.totalPrizeOrder = value ;
    notifyListeners();
  }

  bool initialPrizeCoupon =false ;
  setInitialPrizeCoupon(bool value){
    this.initialPrizeCoupon = value ;
    notifyListeners() ;
  }
}
