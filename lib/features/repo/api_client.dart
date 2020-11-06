import 'dart:convert';
import 'dart:io';

import 'package:beauty/value/constant.dart';
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
  Future<Map> forgetPassword(String email)async{
    await initApi();

    FormData data = FormData.fromMap({
      'email':email
    });
    Response response =await dio.post(
       baseUrl+ forget_password,
      data: data,
    );
    return response.data ;
  }

//////////////////////////////////////////////////////////////////////////////////
resetPassword(int id , String token,String emailPassword ,String newPassword)async{
    await initApi();
    FormData data = FormData.fromMap(
      {
        'user_id':id,
        'token':token,
        'email_password':emailPassword,
        'newPassword':newPassword,
      }
    );
   Response response =await dio.post(
     baseUrl +  reset_password,
     data: data
   );
   return response.data ;
}
/////////////////////////////////////////////////////////////////////////////////
  Future<Map> signOut(String token,String id )async{
    await initApi();

    FormData data = FormData.fromMap({
      'token':token,
      'user_id':id
    });

    Response response =await dio.post(
      baseUrl+ sign_out,
      data: data,
    );

    print("signOut :"+response.data);

    return response.data ;
  }
  /////////////////////////////////////////////////////////////////////////////////
  Future<Map> changePassword(String token,String id,String oldPassword, String newPassword )async{
    await initApi();

    FormData data = FormData.fromMap({
      'token':token,
      'user_id':id,
      'oldPassword':oldPassword,
      'newPassword':newPassword,
    });

    Response response =await dio.post(
      baseUrl+ change_password,
      data: data,
    );

    print("change_password :"+response.data);

    return response.data ;
  }
  /////////////////////////////////////////////////////////////////////////////////
  Future<Map> editProfile(String token,String id,String newName, String newEmail,String mobileNumber )async{
    await initApi();
    FormData data = FormData.fromMap({
      'token':token,
      'user_id':id,
      'new_name':newName,
      'new_email':newEmail,
      'mobile_number':mobileNumber,
    });
    Response response =await dio.post(
      baseUrl+ edit_profile,
      data: data,
    );

    print("edit_profile :"+response.data);
    return response.data ;
  }


//ToDo:Verification



}

