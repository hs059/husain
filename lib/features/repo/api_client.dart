import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/constant.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiClient {
  ApiClient._();

  static ApiClient apiClient = ApiClient._();

  Dio dio;

  initApi() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  Future<Map> registerUser(
      String fullName, String mobile, String password, String email) async {
    await initApi();

    FormData data = FormData.fromMap(
      {
        'full_name': fullName,
        'email': email,
        'password': password,
        'mobile_number': mobile,
      },
    );

    Response response = await dio.post(
      baseUrl + regiserUrl,
      data: data,
    );

    return response.data;
  }

/////////////////////////////////////////////////////////////////////////////////////

  Future<Map> loginUser(String email, String password) async {
    await initApi();
    FormData data = FormData.fromMap(
      {
        'email': email,
        'password': password,
      },
    );

    Response response = await dio.post(
      baseUrl + loginUrl,
      data: data,
    );

    return response.data;
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<Map> forgetPassword(String email) async {
    await initApi();

    FormData data = FormData.fromMap({'email': email});
    Response response = await dio.post(
      baseUrl + forget_password,
      data: data,
    );
    return response.data;
  }

//////////////////////////////////////////////////////////////////////////////////
  Future<Map> resetPassword(
      String id, String token,String newPassword) async {
    await initApi();
    FormData data = FormData.fromMap({
      'user_id': id,
      'token': token,
      'newPassword': newPassword,
    });
    Response response = await dio.post(baseUrl + reset_password, data: data);
    return response.data;
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<Map> signOut(String token, String id) async {
    await initApi();

    FormData data = FormData.fromMap({'token': token, 'user_id': id});

    Response response = await dio.post(
      baseUrl + sign_out,
      data: data,
    );


    return response.data;
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Map> changePassword(
      String token, String id, String oldPassword, String newPassword) async {
    await initApi();
    String token = await SPHelper.spHelper.getToken();
    String idUser = await SPHelper.spHelper.getUser();
    String id = idUser.toString();
    FormData data = FormData.fromMap({
      'user_id': id,
      'token': token,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });

    Response response = await dio.post(
      baseUrl + change_password,
      data: data,
    );


    return response.data;
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Map> editProfile(String token, String id, String newName,
      String newEmail, String mobileNumber) async {
    try {
      await initApi();
      FormData data = FormData.fromMap({
        'id': id,
        'token': token,
        'new_name': newName,
        'new_email': newEmail,
        'mobile_number': mobileNumber,
      });
      Response response = await dio.post(
        baseUrl + edit_profile,
        data: data,
      );
      return response.data;
    } catch (e) {
      print(e);
    }
  }

////////////////////////////////////////////////////////////
  Future<Map> showProfile() async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      String idUser = await SPHelper.spHelper.getUser();
      String id = idUser.toString();
      FormData data = FormData.fromMap({
        'user_id': id,
        'token': token,
      });
      Response response = await dio.post(baseUrl + show_profile, data: data);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
  ////////////////////////////////////////////
  Future<Map> verifyForgetPassword(String id, int verificationCode) async {
    await initApi();
    FormData data = FormData.fromMap({
      "user_id": id,
      "verification_code": verificationCode,
    });

    Response response = await dio.post(
      baseUrl + verify_for_forget_password,
      data: data,
    );
    print(response.data);
    return response.data;
  }
///////////////////////////////////////////////////////

  Future<Map> verification(String id, String verificationCode) async {
    await initApi();
    FormData data = FormData.fromMap({
      "user_id": id,
      "verification_code": verificationCode,
    });

    Response response = await dio.post(
      baseUrl + verify_registration,
      data: data,
    );
    print(response.data);
    return response.data;
  }
  ///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> socialMediaLogin(String socialId ,String userName,String mobileNumber ,String email,String type  )async{
    await initApi() ;
    FormData data = FormData.fromMap({
      "id":socialId,
      "userName":userName,
      "mobileNumber":mobileNumber,
      "email":email,
      "type":type
    });
    Response response = await dio.post(
      baseUrl + register_by_social_media,
      data: data,
    );
    return response.data;
  }
///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> getCategory() async {
    try {
      await initApi();

      Response response = await dio.get(
        baseUrl + get_categories,
      );
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<Map> getSubCategory(int id) async {
    try {
      await initApi();
      Response response =
          await dio.get(baseUrl + get_sub_categories + id.toString());
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future getSlider(int sliderNum) async {
    try {
      await initApi();
      // if(ConnectivityService.connectivityStatus == ConnectivityHStatus.online){
      //   Response response = await dio.get(baseUrl + getSliderIndex[sliderNum]);
      //   print(response.statusCode);
      //   return response.data;
      // }else{
      //   print('offline');
      // }
      Response response = await dio.get(baseUrl + getSliderIndex[sliderNum]);
      print(response.statusCode);
      return response.data;
    } catch (e) {
      if (e is DioError) {}
    }
  }

  Future getSection(String title) async {
    try {
      await initApi();
      Response response = await dio.get(
        baseUrl + title,
      );
      print(response.data);
      // print(response.statusCode==200);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      if (e.response.statusCode == 404) {}
    }
  }

  Future getBrand() async {
    try {
      await initApi();
      Response response = await dio.get(
        baseUrl + get_latest_brands,
      );
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future getSubProduct(int id, String userId,) async {
    try {
      await initApi();
      Response response = await dio.get(
        'https://3beauty.net/wp-json/beauty/v1/get_product_by_category?cat_id=$id&user_id=$userId',
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('statusCode aaaaaaaaaaaaaaaaaa');
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }

  Future getProductByCategory(int id) async {
    try {
      await initApi();
      String idUser = await SPHelper.spHelper.getUser();
      Response response = await dio.get(
        'https://3beauty.net/wp-json/beauty/v1/get_recommended_products?product_id=$id&user_id=$idUser',
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('statusCode aaaaaaaaaaaaaaaaaa');
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }

  Future getSearch(String search) async {
    try {
      await initApi();

      Response response = await dio.get(
        'https://3beauty.net/wp-json/beauty/v1/get_product_like?search_txt=$search',
      );
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        throw Exception('error');
      }
    } on DioError catch (e) {
      print(e.response.statusCode);
    }
  }

  Future getProductByBrand(int id,String userId,) async {
    try {
      await initApi();
      Response response = await dio
          .get(baseUrl + 'get_products_by_brand?brand_id=$id&user_id=$userId');
      return response.data;
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }

  Future getProductDetails(int id,String userId,
      ) async {
    try {
      await initApi();
      Response response = await dio.get(baseUrl + 'get_product?id=$id&user_id=$userId');
      Logger().d(response.data);
      return response.data;
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }

  Future onBoarding() async {
    try {
      await initApi();
      Response response = await dio.get(baseUrl + get_front_page_slides);
      return response.data;
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }

  Future getPrivacyPolicy() async {
    try {
      await initApi();
      Response response = await dio.get(baseUrl + get_privacy_policy);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }

  Future createOrder(
      String userId,
    String token,
    String name,
    String address1,

    String houseNum,
    String apartment,

    List<Map> product,
  ) async {
    try {
      await initApi();

      FormData data = FormData.fromMap({
        "user_id": userId,
        "token": token,
        "shipping": {
          "first_name": name,
          "last_name": "last_name",
          "address_1": address1,
          "address_2": "house_number:$houseNum , apartment :$apartment",
          "country": 'on_address_1',
          "state": " on_address_1",
          "city": 'on_address_1'
        },
        "line_items": product
      });
      print({
        "user_id": userId,
        "token": token,
        "shipping": {
          "first_name": name,
          "last_name": "on first Name",
          "address_1": address1,
          "address_2": "house_number:$houseNum , apartment :$apartment",
          "country": '',
          "state": "",
          "city": ''
        },
        "line_items": product
      });
      Response response = await dio.post(baseUrl + create_order, data: data);
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }

  getAllOrder() async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      String idUser = await SPHelper.spHelper.getUser();
      String id = idUser.toString();
      FormData data = FormData.fromMap({
        "user_id": id,
        "token": token,
      });
      Response response = await dio.post(baseUrl + get_orders, data: data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Map> addNewAddress(
    String type,
    String phone,
    String address,
    String houseNumber,
    String apartment,
    bool IsDefault,
  ) async {
    await initApi();
    String token = await SPHelper.spHelper.getToken();
    String idUser = await SPHelper.spHelper.getUser();
    FormData data = FormData.fromMap({
      'user_id': idUser,
      'token': token,
      'type': type,
      'phone': phone,
      'address': address,
      'house_number': houseNumber,
      'apartment': apartment,
      'IsDefault': IsDefault,
    });
    Response response = await dio.post(baseUrl + add_address, data: data);
    if (response.statusCode == 200) {
      return response.data;
    }
  }

  Future<Map> getAllAddress() async {
    String token = await SPHelper.spHelper.getToken();
    String idUser = await SPHelper.spHelper.getUser();
    FormData data = FormData.fromMap({
      'user_id': idUser,
      'token': token,
    });
    Response response = await dio.post(baseUrl + get_address, data: data);
    if (response.statusCode == 200) {
      return response.data;
    }
  }

  Future<Map> removeAdress(int addressId) async {
    String token = await SPHelper.spHelper.getToken();
    String idUser = await SPHelper.spHelper.getUser();
    FormData data = FormData.fromMap({
      'user_id': idUser,
      'token': token,
      'address_id': addressId,
    });
    Response response = await dio.post(baseUrl + remove_address, data: data);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    }
  }

  Future<Map> addRev(
    int productId,
    double RatingCount,
    String comment,
  ) async {
    String token = await SPHelper.spHelper.getToken();
    String idUser = await SPHelper.spHelper.getUser();
    FormData data = FormData.fromMap({
      "user_id": idUser,
      "token": token,
      "product_id": productId,
      "rating_count": RatingCount,
      "comment": comment,
    });

    Response response =await dio.post(
        baseUrl + add_reviews,
        data: data ,
    );
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    }
  }
  Future<Map> getTermsAndConditions() async {
    try {
      await initApi();
      Response response = await dio.get(baseUrl + get_terms_and_conditions);
      if(response.statusCode == 200 ){
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }
Future<Map> addFav(int productId)async{
    try {
      await initApi() ;
      String idUser = await SPHelper.spHelper.getUser();

      FormData data  = FormData.fromMap({
        "user_id":idUser,
        "product_id":productId,
      });
      Response response = await dio.post(
        baseUrl + add_product_to_wishlist ,
        data:data
      );

      if(response.statusCode == 200 ){
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }

}
Future<Map> removeFav(int productId)async{
    try {
      await initApi() ;
      String idUser = await SPHelper.spHelper.getUser();

      FormData data  = FormData.fromMap({
        "user_id":idUser,
        "products":[
          {
            "id":productId
          }
        ]
      });
      Response response = await dio.post(
        baseUrl + remove_product_from_wishlist ,
        data:data
      );

      if(response.statusCode == 200 ){
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }

}

getAllFav()async{
  try {
    await initApi() ;
    String idUser = await SPHelper.spHelper.getUser();

    FormData data  = FormData.fromMap({
      "user_id":idUser
    });
    Response response = await dio.post(
        baseUrl + get_favourite_products ,
        data:data
    );

    if(response.statusCode == 200 ){
      return response.data;
    }
  } on DioError catch (e) {
    if (e.response.statusCode != 200) {
      print(e.response.statusCode);
    } else {
      print(e.message);
      print(e.request);
    }
  }
}

  Future<Map> sortByCategory(int subCategoryId , String type)async{
    try {
      await initApi() ;
      print('subCategoryId $subCategoryId type $type');
      Response response =await dio.get(
       baseUrl+'sort_products_by?type=$type&category_id=$subCategoryId'
       // baseUrl+'sort_products_by?type=low_to_high&category_id=63'
      );

      return response.data ;
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }


}
