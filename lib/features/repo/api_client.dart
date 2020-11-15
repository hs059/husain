import 'package:beauty/services/connectivity.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/constant.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

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

  Future<Map> registerUser(String fullName, String mobile, String password,
      String email) async {
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

    print(response.data);
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

    print(response.data);
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
  Future<Map> resetPassword(int id, String token, String emailPassword,
      String newPassword) async {
    await initApi();
    FormData data = FormData.fromMap({
      'user_id': id,
      'token': token,
      'email_password': emailPassword,
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

    print( response.data);

    return response.data;
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Map> changePassword(String token, String id, String oldPassword,
      String newPassword) async {
    await initApi();
    String token = await SPHelper.spHelper.getToken();
    int idUser = await SPHelper.spHelper.getUser();
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

    print(response.data);

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
      print(response.data);
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
      int idUser = await SPHelper.spHelper.getUser();
      String id = idUser.toString();
      FormData data = FormData.fromMap({
        'user_id': id,
        'token': token,
      }
      );
      print( ' token : $token user_id : $id');

      Response response = await dio.post(
          baseUrl + show_profile,
          data: data
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }


//ToDo:Verification

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
      if (e is DioError) {

      }
    }
  }

  Future getSection(String title) async {
    try {
      await initApi();
      Response response = await dio.get(
        baseUrl + title,
      );
      print(response.statusCode);

      return response.data;
    } catch (e) {
      print(e);
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

  Future getSubProduct(int id) async {
    try {
      await initApi();
      Response response = await dio.get(
        'https://3beauty.net/wp-json/beauty/v1/get_product_by_category?cat_id=$id&user_id=25',
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
      Response response = await dio.get(
        'https://3beauty.net/wp-json/beauty/v1/get_recommended_products?product_id=$id',
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
      }
      else {
        throw Exception('error');
      }
    } on DioError catch (e) {
      print(e.response.statusCode);
    }
  }


  Future getProductByBrand(int id) async {
    try {
      await initApi();
      Response response = await dio.get(
          baseUrl + 'get_products_by_brand?brand_id=$id&user_id='
      );
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

  Future getProductDetails(int id) async {
    try {
      await initApi();
      Response response = await dio.get(
          baseUrl + 'get_product?id=$id&user_id'
      );
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
      Response response = await dio.get(
          baseUrl + get_front_page_slides
      );
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
      Response response = await dio.get(
          baseUrl + get_privacy_policy
      );
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
}