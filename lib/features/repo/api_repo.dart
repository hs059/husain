import 'package:beauty/components/model/productM.dart';
import 'package:beauty/components/model/productModel.dart';
import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/model/categoryModel.dart';
import 'package:beauty/components/model/sectionModel.dart';
import 'package:beauty/components/model/sliderModel.dart';
import 'package:beauty/components/model/subCategoryModel.dart';
import 'package:beauty/features/repo/api_client.dart';

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
    Map map = await ApiClient.apiClient.getSubProduct(id);
    ProductModel subProductModel = ProductModel.fromJson(map);
    return subProductModel;
  }

  Future<ProductModel> getProductByBrand(int id) async {
    Map map = await ApiClient.apiClient.getProductByBrand(id);
    ProductModel productModel = ProductModel.fromJson(map);
    return productModel;
  }
  Future<ProductM> getProductDetails(int id) async {
    Map map = await ApiClient.apiClient.getProductDetails(id);
    ProductM productM = ProductM.fromJson(map);
    return productM;
  }

}
